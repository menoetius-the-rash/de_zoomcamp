
import argparse
import os
import pandas as pd
from sqlalchemy import create_engine
from time import time

def main(params):
    user = params.user
    pw = params.pw
    host = (params.host)
    port = (params.port)
    db = params.db
    table_name = params.table_name
    url = (params.url)
    csv_name = 'output.csv'

    # the backup files are gzipped, and it's important to keep the correct extension
    # for pandas to be able to open the file
    if url.endswith('.csv.gz'):
        csv_name = 'output.csv.gz'
    else:
        csv_name = 'output.csv'
    
    # download the csv
    os.system(f'wget {url} -O {csv_name}')

    engine = create_engine(f'postgresql://{user}:{pw}@{host}:{port}/{db}')

    # engine.connect()

    # Create the DDL in Postgresql DB
    # print(pd.io.sql.get_schema(df, name='yellow_taxi_data', con=engine))


    # Use iterator to read CSV file in chunks of 100000
    print(os.getcwd())
    df_iter = pd.read_csv(csv_name, iterator=True, chunksize=100000)

    df = next(df_iter)

    # convert to datetime
    df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
    df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

    # Creates the table with only headers
    df.head(n=0).to_sql(name=table_name, con=engine, if_exists='replace')

    df.to_sql(name=table_name, con=engine, if_exists='append')
    # create a loop that will iterate through chunks and append the data to the yellow_taxi_data table in the DB
    while True:
        try:
            t_start = time()

            df = next(df_iter)

            df.tpep_pickup_datetime = pd.to_datetime(df.tpep_pickup_datetime)
            df.tpep_dropoff_datetime = pd.to_datetime(df.tpep_dropoff_datetime)

            df.to_sql(name=table_name, con=engine, if_exists='append')
            
            t_end = time()

            print('Chunk inserted.. Time taken: %.3f seconds' %(t_end - t_start))
        except StopIteration:
            print('Finished data ingestion to postgres DB')
            break


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Ingest CSV data to Postgres')

    # user
    # pw
    # host
    # port
    # db
    # table_name
    # url 
    parser.add_argument('--user',help='username for postgres')
    parser.add_argument('--pw',help='pw for postgres')
    parser.add_argument('--host',help='host for postgres')
    parser.add_argument('--port',help='port for postgres')
    parser.add_argument('--db',help='db name for postgres')
    parser.add_argument('--table_name',help='table name for postgres')
    parser.add_argument('--url',help='url of the csv file')

    args = parser.parse_args()

    main(args)


