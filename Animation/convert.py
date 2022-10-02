from PIL import Image
import json
import os


# correct file encoding using powershell and create folder for
# decompiled image atlas
powershell = """
powershell -command \" gci . |
    where { $_.Extension -match 'json' } |
    foreach {
        New-Item -ItemType Directory -Name $_.BaseName -Force;
        (get-content $_.FullName) | Set-Content $_.FullName -Encoding ASCII
    }\"
""".replace("\n", "")

os.system(powershell)

json_files = [file for file in os.listdir('.') if file.endswith('json')]

for file in json_files:

    folder = file.replace('.json', '')

    img = Image.open("{}.png".format(folder))
    with open(file, "r", encoding='ascii') as f:
        j = ''.join(f.readlines())
        sprite_json = json.loads(j)

        for framename in sprite_json['frames']:
            x = sprite_json['frames'][framename]['frame']['x']
            y = sprite_json['frames'][framename]['frame']['y']
            w = sprite_json['frames'][framename]['frame']['w']
            h = sprite_json['frames'][framename]['frame']['h']
            img.crop((x,y,x+w,y+h)).save("{}\\{}.png".format(folder, framename))