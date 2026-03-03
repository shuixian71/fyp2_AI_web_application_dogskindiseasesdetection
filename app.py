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

if __name__ == "__main__":
    app.run(debug=True)