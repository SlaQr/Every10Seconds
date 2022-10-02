from PIL import Image
import json
import os

# correct file encoding using powershell and create folder for
# decompiled images from atlas based on JSON and PNG file name
powershell = """
powershell -command \" gci . |
    where { $_.Extension -match 'json' } |
    foreach {
        New-Item -ItemType Directory -Name $_.BaseName -Force;
        (get-content $_.FullName) | Set-Content $_.FullName -Encoding ASCII
    }\"
""".replace("\n", "")

os.system(powershell)

# get json files in current directory
json_files = [file for file in os.listdir('.') if file.endswith('json')]

for file in json_files:

    # remove JSON extension from filename
    # the name should have a PNG file variant in the same directory
    folder = file.replace('.json', '')

    # load the compressed atlas
    img = Image.open("{}.png".format(folder))

    # open json file and parse contents
    # JSON object is expected, not an array
    with open(file, "r", encoding='ascii') as f:
        j = ''.join(f.readlines())
        sprite_json = json.loads(j)

        # loop through animation frames in file
        for framename in sprite_json['frames']:
            # grab frame dimensions within atlas
            x = sprite_json['frames'][framename]['frame']['x']
            y = sprite_json['frames'][framename]['frame']['y']
            w = sprite_json['frames'][framename]['frame']['w']
            h = sprite_json['frames'][framename]['frame']['h']

            # export frame as a standalone image and save
            # under json filename folder, using the frame 
            # name as the PNG name
            img.crop((x,y,x+w,y+h)).save("{}\\{}.png".format(folder, framename))