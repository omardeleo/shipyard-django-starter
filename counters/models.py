from django.db import models

class Counter(models.Model):
  value = models.IntegerField(default=1)
  created_at = models.DateTimeField(auto_now_add=True)
  updated_at = models.DateTimeField(auto_now=True)
