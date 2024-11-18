import os

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
    try:
        os.makedirs(folder_path)
    except OSError:
        pass