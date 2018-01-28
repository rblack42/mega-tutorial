include debug.mak
.DEFAULT_GOAL	:= run

.PHONY: prep
all:	init_venv reqs

.PHONY: init_venv
init_venv:
	if [ ! -e "_venv/bin/activate_this.py" ] ; then \
		PYTHONPATH=_venv ; \
		python3 -m venv _venv ; \
	fi

.PHONY: reqs
reqs:	requirements.txt
	PYTHONPATH=_venv ; . _venv/bin/activate && \
	_venv/bin/pip install -Ur requirements.txt

.PHONY: run
run:	_venv microblog/microblog.py
	cd microblog && \
	export FLASK_APP=microblog.py && \
	export SECRET_KEY=test-secret-key && \
	export FLASK_DEBUG=0 && \
	export MAIL_SERVER=localhost && \
	export MAIL_PORT=8025 && \
	flask run

.PHONY: db_init
db_init:	_venv
	cd microblog && \
	export FLASK_APP=microblog.py && \
	flask db init

.PHONY: db_migrate
db_migrate:	_venv
	cd microblog && \
	export FLASK_APP=microblog.py && \
	flask db migrate

.PHONY: db_upgrade
db_upgrade:	_venv
	cd microblog && \
	export FLASK_APP=microblog.py && \
	flask db upgrade

.PHONY: shell
shell:	_venv
	cd microblog && \
	export FLASK_APP=microblog.py && \
	flask shell

.PHONY:	fakemail
fakemail:
	sudo python -m smtpd -n -c DebuggingServer localhost:8025 

