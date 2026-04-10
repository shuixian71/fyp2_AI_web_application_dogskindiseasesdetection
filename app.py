#import
from flask import Flask, render_template, redirect, request, jsonify
import numpy as np
from PIL import Image
import tensorflow as tf
import io
import os
from werkzeug.utils import secure_filename
from flask_mysqldb import MySQL
from datetime import datetime
from dotenv import load_dotenv
load_dotenv()
#My App
app = Flask(__name__)

#configure the database connection
app.config['MYSQL_HOST']= os.getenv("MYSQL_HOST")
app.config['MYSQL_USER'] = os.getenv("MYSQL_USER")
app.config['MYSQL_PASSWORD'] = os.getenv("MYSQL_PASSWORD")
app.config['MYSQL_DB'] = os.getenv("MYSQL_DB")
mysql = MySQL(app)

 #check whether database connected or not 
@app.route('/test_db')
def test_db():
    try:
        cur = mysql.connection.cursor()
        cur.execute("SELECT 1")
        return "Database connected"
    except Exception as e:
        return str(e)

#load the fine tuned model
MODEL_PATH = os.path.join(os.path.dirname(__file__), 'model', 'best_model_V8.keras')
model = tf.keras.models.load_model(MODEL_PATH)

#Matching the class labels with the one trained in the google colab
CLASS_NAMES = [
    'Dermatitis',
    'Fungal_infections',
    'Healthy',
    'Hypersensitivity',
    'Demodicosis',
    'Ringworm'
]

# image preprocessing part
def preprocess_image(image_bytes):
    img = Image.open(io.BytesIO(image_bytes)).convert('RGB')
    img = img.resize((224,224))
    img_array = np.array(img) /255.0
    img_array = np.expand_dims(img_array, axis=0)
    return img_array


@app.route("/")
#home page
def index():
    return render_template('home.html', active_page="home")


@app.route("/information")
def information():
    return render_template('information.html', active_page="information")

@app.route("/detection")
def detection():
    return render_template('detection.html', active_page="detection")

@app.route("/ringworm")
def ringworm():
    return render_template('ringworm.html', active_page="information")

@app.route("/hypersensitivity")
def hypersensitivity():
    return render_template('hypersensitivity.html', active_page='information')

@app.route("/dermatitis")
def dermatitis():
    return render_template('dermatitis.html', active_page='information')

@app.route("/demodicosis")
def demodicosis():
    return render_template('demodicosis.html', active_page='information')

@app.route("/fungal_infection")
def fungal_infection():
    return render_template('fungal_infection.html', active_page='information')

#route for predict and result
@app.route('/result')
def result():
    disease = request.args.get('disease','Unknown')
    confidence = request.args.get('confidence', 'N/A')
    image_filename = request.args.get('image', None)
    return render_template('result.html', disease=disease, confidence=confidence, image_filename= image_filename, active_page='detection')

@app.route('/predict', methods=['POST'])
def predict():
    if 'file' not in request.files:
        return jsonify({'error': 'No file uploaded'}), 400

    file = request.files['file']

    if file.filename == '':
        return jsonify({'error' : 'No file uploaded'}), 400

    filename = secure_filename(file.filename) #the variable defined for image uploaded by user

    #save the uploaded  images into the folder uploaded_images in static folder
    # save_path = os.path.join('static','uploads',filename)
    # file.save(save_path)

    # if file.filename =='':
    #     return jsonify({'error': 'No file selected'}), 400
    
    try:
        image_bytes = file.read()
        file.seek(0)

        #save the uploaded  images into the folder uploaded_images in static folder
        save_path = os.path.join('static','uploads',filename)
        file.save(save_path)

        processed = preprocess_image(image_bytes)
        predictions = model.predict(processed)
        predicted_index = np.argmax(predictions[0])
        predicted_class = CLASS_NAMES[predicted_index]
        confidence = float(np.max(predictions[0])) * 100

        #connect and configure
        cur = mysql.connection.cursor()

    #write the sql queires
        cur.execute("""
            INSERT INTO picture_uploaded (image_path,upload_date) VALUES (%s, %s)
        """, (save_path,datetime.now()))

        mysql.connection.commit()

        #gget the uploaded id of image
        upload_id = cur.lastrowid

        cur.execute("""
        INSERT INTO detection_result(upload_id, disease_name, confidence_level) VALUES (%s, %s, %s)
        """, (upload_id, predicted_class,confidence))

        mysql.connection.commit()
        cur.close()

        return jsonify({
            'disease': predicted_class,
            'confidence': f'{confidence:.2f}%',
            'image_filename': filename
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500
if __name__ == "__main__":
    app.run(debug=True)