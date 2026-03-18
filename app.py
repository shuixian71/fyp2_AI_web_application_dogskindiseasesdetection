#import
from flask import Flask, render_template, redirect

#My App
app = Flask(__name__)

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

if __name__ == "__main__":
    app.run(debug=True)