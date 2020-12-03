from django.shortcuts import render
from django.http import HttpResponse
from django.template import loader

from .models import Counter

def index(request):
    counter = Counter.objects.last()
    if counter:
        counter.value = counter.value + 1
        counter.save()
    else:
        counter = Counter()
        counter.save()
    template = loader.get_template('counters/index.html')
    context = {
        'counter': counter.value
    }
    return HttpResponse(template.render(context, request))