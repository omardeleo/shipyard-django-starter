from django.shortcuts import render
from django.http import HttpResponse

from .models import Counter

def index(request):
    counter = Counter.objects.last()
    if counter:
        counter.value = counter.value + 1
        counter.save()
    else:
        counter = Counter()
        counter.save()
    return HttpResponse(counter.value)