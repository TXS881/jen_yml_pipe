#import findspark
#findspark.init()
import pyspark
from pyspark.sql import SparkSession
from pyspark import SparkContext

sc = SparkSession.builder.appName('myapp').getOrCreate()

from pyspark.sql.functions import *
from pyspark.sql.window import Window
sc.conf.set("spark.sql.autoBroadcastJoinThreshold",-1)
from pyspark.sql import Row
from pyspark.sql.types import *

sc = SparkSession.builder.appName('myapp').getOrCreate()

# Read File
path = '/home/ubuntu/Project/radar.csv'

def read_inputFile(f_path):
    input_file = sc.read.format('csv').option('header','true').option('inferSchema','true').load(f_path)
    return input_file
v = read_inputFile(path)

# Save file
v.coalesce(1).write.mode('overwrite').save('/home/ubuntu/Project/readar_clean.csv')
