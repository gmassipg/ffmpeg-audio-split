# ffmpeg-audio-split
This bash script allows you to split a long audio file into shorter files of any length, each with their custom name.                           
                                                                            
Usage from the command line:     
```
ffmpeg-audio-split.sh <original_audio_file.mp3> <timestamps.txt>  
```
                                                                            
This script has been tested on mp3 files, but should work with all audio formats compatible with FFmpeg                                              
                                                                             
timestamps.txt format example: 
```
00:00:00 00:02:04 name_of_file1.mp3                                         
00:02:04 00:05:37 name_of_file2.mp3
```
                                      
All timestamps have to be in `HH:MM:SS` format. The name of each resulting audio file has to include its extension (in the case above, .mp3), or the script won't work properly.                                                 

