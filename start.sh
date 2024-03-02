# Start the cron daemon in the background
cron &

# Execute the Python script
python /app/etl_script.py