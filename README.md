# calc_oss_cost
Rough calculation of the cost to create OSS software.  Point script at github repo and get table of SLOC with cost estimate.  Debatable value.

## CLOC
Uses this tool to scan software and gather Lines of Code statistics.

https://github.com/AlDanial/cloc

In this case I use the docker image.  So you will need to have docker installed be connected to the internet.

## Python3

Script uses bash and Python3

## Install

1) Pull CLOC docker image
2) Clone this repo
3) Change directory into the repo
3) Make sure the script `git_cloc.sh` is executable

```
% docker load mribeiro/cloc
% git clone https://github.com/schnorea/calc_oss_cost.git
% cd calc_oss_cost
% chmod +x git_cloc.sh
```

## To Run
1) Find Github repo you would like to estimate the cost on and copy the repo cloning url
2) Run `git_cloc.sh` script with repo clone url string
3) Examine cloc_out.json for statistics and cost estimate

Find repo clone url

Image goes here

```
% ./git_cloc.sh  https://github.com/Retail-Edge-Platform/Retail-Edge-Platform.git
```

Output in `cloc_out.json` would look like this
```
{
    "Git-Repo": "https://github.com/Retail-Edge-Platform/Retail-Edge-Platform.git",
    "CSS": {
        "files": 16,
        "blank": 8035,
        "comment": 138,
        "code": 33836,
        "cost": 609048
    },
    "Javascript": {
        "files": 21,
        "blank": 5538,
        "comment": 3647,
        "code": 19821,
        "cost": 356778
    },
    "HTML": {
        "files": 8,
        "blank": 1926,
        "comment": 6,
        "code": 14173,
        "cost": 255114
    },
    "Python": {
        "files": 9,
        "blank": 191,
        "comment": 340,
        "code": 679,
        "cost": 12222
    },
    "YAML": {
        "files": 1,
        "blank": 8,
        "comment": 1,
        "code": 64,
        "cost": 1152
    },
    "sum": {
        "files": 55,
        "blank": 15698,
        "comment": 4132,
        "code": 68573,
        "cost": 1234314
    }
}
```

