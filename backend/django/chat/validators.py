from django.core.exceptions import ValidationError
import os
from django.apps import apps



# Audio file validator
def validate_audio_file_extension(value):
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.mp3', '.wav', '.ogg']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.')
    
# Video file validator
def validate_video_file_extension(value):
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.mp4', '.webm', '.ogg']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.')
    
# Document file validator
def validate_document_file_extension(value):
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.pdf', '.doc', '.docx', '.ppt', '.pptx', '.xls', '.xlsx']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.')
    
# Image file validator
def validate_image_file_extension(value):
    ext = os.path.splitext(value.name)[1]  # [0] returns path+filename
    valid_extensions = ['.png', '.jpg', '.jpeg', '.gif']
    if not ext.lower() in valid_extensions:
        raise ValidationError('Unsupported file extension.')
    
# Message file validator
def validate_file_based_on_type(file):
    if file is None:
        raise ValidationError('File is required')
    else:
        Message = apps.get_model('chat', 'Message')
        instance = file.instance

        if instance.message_type == Message.AUDIO:
            validate_audio_file_extension(file)
        elif instance.message_type == Message.IMAGE:
            validate_image_file_extension(file)
        elif instance.message_type == Message.VIDEO:
            validate_video_file_extension(file)
        elif instance.message_type == Message.DOCUMENT:
            validate_document_file_extension(file)
       