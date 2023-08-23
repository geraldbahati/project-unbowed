from rest_framework.serializers import ModelSerializer
from .models import Doc, Text, Context, Answer, Docs


class DocSerializer(ModelSerializer):
    class Meta:
        model = Doc
        fields = (
            "id",
            "docname",
            "citation",
            "dockey",
            "is_deleted",
        )

        extra_kwargs = {
            "id": {"read_only": True},
            "is_deleted": {"read_only": True},
        }


class TextSerializer(ModelSerializer):
    class Meta:
        model = Text
        fields = (
            "id",
            "text",
            "name",
            "doc",
            "embeddings",
        )

        extra_kwargs = {
            "id": {"read_only": True},
        }


class ContextSerializer(ModelSerializer):
    class Meta:
        model = Context
        fields = (
            "id",
            "context",
            "text",
            "score",
        )

        extra_kwargs = {
            "id": {"read_only": True},
        }


class AnswerSerializer(ModelSerializer):
    class Meta:
        model = Answer
        fields = (
            "id",
            "question",
            "answer",
            "context",
            "contexts",
            "references",
            "formatted_answer",
            "summary_length",
            "answer_length",
            "memory",
            "cost",
            "token_counts",
        )

        extra_kwargs = {
            "id": {"read_only": True},
        }


class DocsSerializer(ModelSerializer):
    class Meta:
        model = Docs
        fields = (
            "id",
            "docs",
            "llm",
            "summary_llm",
            "name",
            "index_path",
            "max_concurrent",
            "memory",
            "jit_texts_index",
        )

        extra_kwargs = {
            "id": {"read_only": True},
        }