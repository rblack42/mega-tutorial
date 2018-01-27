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
	export FLASK_APP=microblog/microblog.py && \
	export SECRET_KEY=test-secret-key && \
	flask run

.PHONY: db_init
db_init:	_venv
	export FLASK_APP=microblog/microblog.py && \
	flask db init

.PHONY: db_migrate
db_migrate:	_venv
	export FLASK_APP=microblog/microblog.py && \
	flask db migrate

.PHONY: db_upgrade
db_upgrade:	_venv
	export FLASK_APP=microblog/microblog.py && \
	flask db upgrade

.PHONY: shell
shell:	_venv
	export FLASK_APP=microblog/microblog.py && \
	flask shell

