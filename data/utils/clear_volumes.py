import os
import shutil

script_directory = os.path.dirname(os.path.abspath(__file__))
data_dir = os.path.abspath(os.path.join(script_directory, os.pardir))
folder_list = ['/grafana',
               '/kafka/data',
               '/kafka/secrets',
               '/nifi/conf',
               '/nifi/content_repository',
               '/nifi/database_repository',
               '/nifi/flowfile_repository',
               '/nifi/logs',
               '/nifi/provenance_repository',
               '/nifi/state',
               '/nifi/utils',
               '/timescaledb',
               '/zookeeper/data',
               '/zookeeper/datalog'
               ]

for folder in folder_list:
    folder_path = data_dir + folder
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
            elif os.path.isdir(file_path):
                shutil.rmtree(file_path)
        except Exception as e:
            print('Failed to delete %s. Reason: %s' % (file_path, e))