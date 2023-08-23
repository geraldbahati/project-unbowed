from django.contrib import admin
from .models import Doc, Text, Context, Answer, Docs

# Register your models here.
admin.site.register(Doc)
admin.site.register(Text)
admin.site.register(Context)
admin.site.register(Answer)
admin.site.register(Docs)
