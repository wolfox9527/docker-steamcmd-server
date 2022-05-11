until Xvfb :99 -screen 0 1x1x24 -nolisten tcp; do
    echo "Xvfb server crashed with exit code $?.  Respawning.." >&2
    sleep 1
done