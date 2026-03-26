#import
from flask import Flask, render_template, redirect, request, jsonify
import numpy as np
from PIL import Image
import tensorflow as tf
import io
import os
from werkzeug.utils import secure_filename

#My App
app = Flask(__name__)

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
    'ringworm'
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

#route for upload new image button
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

        return jsonify({
            'disease': predicted_class,
            'confidence': f'{confidence:.2f}%',
            'image_filename': filename
        })
    
    except Exception as e:
        return jsonify({'error': str(e)}), 500
if __name__ == "__main__":
    app.run(debug=True)