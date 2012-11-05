echo 'Begin record...'
arecord -d 3 -q -f cd -r 16000 speech.wav
echo 'End record'
sox speech.wav speech.flac gain -n -5 silence 1 5 2%
rm speech.wav
echo 'Voice analysis'
wget -q -U "Mozilla/5.0" --post-file speech.flac --header="Content-Type: audio/x-flac; rate=16000" -O - "http://www.google.com/speech-api/v1/recognize?lang=en-US&client=chromium" > all.ret
rm speech.flac
cat all.ret | sed 's/.*utterance":"//' | sed 's/","confidence.*//' > text.txt
cat all.ret | sed 's/.*confidence"://' | sed 's/}]}.*//' > confidence.txt
rm all.ret
TEXT="$(cat text.txt)"
CONFIDENCE="$(cat confidence.txt)"
rm text.txt
rm confidence.txt
echo $TEXT
echo $CONFIDENCE
