
from flask import render_template
from app import app

@app.route('/')
@app.route('/index')
def index():
    user = {'username': 'rblack'}
    posts = [
        {
            'author': {'username': 'John'},
            'body': 'Butiful day in the neighborood'
        },
        {
            'author': {'username': 'Susan'},
            'body': 'The Avenger movie was cool'
        }
    ]
    return render_template(
            'index.jinja', 
            title='Home', 
            user=user,
            posts = posts
    )

