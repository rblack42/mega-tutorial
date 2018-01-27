
from flask import render_template, flash, redirect, url_for
from app import app
from app.forms import LoginForm

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

@app.route('/login', methods=['GET', 'POST'])
def login():
    form = LoginForm()
    if form.validate_on_submit():
        flash('login requested for user {}, remember_me={}'.format(
            form.username.data, form.remember_me.data))
        return redirect(url_for('index'))
    return render_template('login.jinja', title='SIgn In', form=form)
