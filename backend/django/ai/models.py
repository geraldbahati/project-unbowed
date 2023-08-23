from django.db import models

class Doc(models.Model):
    docname = models.CharField(max_length=255)
    citation = models.TextField()
    dockey = models.TextField()  # Assuming dockey is a string, but adjust as needed.
    is_deleted = models.BooleanField(default=False)

class Text(models.Model):
    text = models.TextField()
    name = models.CharField(max_length=255)
    doc = models.ForeignKey(Doc, on_delete=models.CASCADE)
    embeddings = models.JSONField(null=True, blank=True)

class Context(models.Model):
    context = models.TextField()
    text = models.ForeignKey(Text, on_delete=models.CASCADE)
    score = models.IntegerField(default=5)

class Answer(models.Model):
    question = models.TextField()
    answer = models.TextField(default="")
    context = models.TextField(default="")
    contexts = models.ManyToManyField(Context)
    references = models.TextField(default="")
    formatted_answer = models.TextField(default="")
    summary_length = models.CharField(max_length=255, default="about 100 words")
    answer_length = models.CharField(max_length=255, default="about 100 words")
    memory = models.TextField(null=True, blank=True)
    cost = models.FloatField(null=True, blank=True)
    token_counts = models.JSONField(null=True, blank=True)

    def __str__(self):
        return self.formatted_answer


class Docs(models.Model):
    # ForeignKey relationships will be handled in the related model.
    docs = models.ManyToManyField(Doc)

    # For simplicity, assuming llm can be a string representation.
    llm = models.TextField(default="ChatOpenAI with gpt-3.5-turbo")
    summary_llm = models.TextField(null=True, blank=True)

    name = models.CharField(max_length=255, default="default")
    index_path = models.CharField(max_length=255)
    
    max_concurrent = models.IntegerField(default=5)
    memory = models.BooleanField(default=False)
    jit_texts_index = models.BooleanField(default=False)

    def __str__(self):
        return self.name