from __future__ import absolute_import, unicode_literals
import os

from celery import Celery
from django.conf import settings
from pytz import timezone

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'project_unbowed.settings')

app = Celery('project_unbowed')
# app.conf.enable_utc = False

# app.conf.update(timezone = '')
app.config_from_object(settings, namespace='CELERY')

#CELERY BEAT SETTINGS
app.conf.beat_schedule = {
    
}

app.autodiscover_tasks()

@app.task(bind =True)
def debug_task(self):
    print(f'Request: {self.request!r}')