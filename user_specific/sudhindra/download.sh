


movie_folder=$1
song_name_token=$2
count_of_songs=$3

server_name=$4

`mkdir $movie_folder`
echo "downloading $count_of_songs songs rom movie: $movie_folder with song name token : $song_name_token"

for id in $( seq $count_of_songs ); do 

	song_url="http://${server_name}.mp3pk.com/indian/${movie_folder}/${song_name_token}${id}%28www.songs.pk%29.mp3"
	
	echo "now downloading ... ${song_url}"
	wget -P $movie_folder $song_url
done
