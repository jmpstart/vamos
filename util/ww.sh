#!/bin/bash
# ww.sh - workwith (work with given environment)
# use with ww (alias ww='source ww.sh')

   if [ "$*" == "-?" ]; then
      echo '   usage: ww <topic>          # work with environment'
      echo '          ww                  # cd $WORK'
      echo '          ww .                # set WORK=`pwd`'
      echo '          ww ..               # cd to parent directory and ww .'
      echo '          ww ai               # work with AI (Semantic)'
      echo '          ww ae               # work with Altium Etc'
      echo '          ww al               # work with Altium Library'
      echo '          ww ap               # work with Altium Playground'
      echo '          ww <n>              # cd to directory <n>-... and ww .'
      echo ''
      echo '          ww bdoc             # work with Bluccino/bluccino-doc'
      echo '          ww bs               # work with Bluco SW'
      echo '          ww bh               # work with Bluco HW development'
      echo '          ww bm               # work with Bluco Manufacturing'
      echo '          ww bpj              # work with Bluco Project'
      echo '          ww bl               # work with Bluccino'
      echo '          ww pr               # work with Bluccino/principles'
      echo '          ww br               # work with Blue Railway'
      echo '          ww bq               # work with Bluccino/quicktour'
      echo '          ww bd               # work with Bluccino/bluccino-develop'
      echo '          ww bdl              # work with Bluccino/bluccino-develop/lessons'
      echo '          ww bds              # work with Bluccino/bluccino-develop/samples'
      echo '          ww bdo              # work with Bluccino/docker'
      echo '          ww bp               # work with Bluccino/bluccino-pico'
      echo '          ww bt               # work with Bluccino/Tutorial'
      echo '          ww c                # work with Conda'
      echo '          ww d                # work with Doc'
      echo '          ww do               # work with Docker'
      echo '          ww e                # work with Environment'
      echo '          ww f                # work with 36zero'
      echo '          ww fb               # work with 36zero/beacon'
      echo '          ww fg               # work with 36zero/gateway'
      echo '          ww fl               # work with 36zero/libraries'
      echo '          ww fw               # work with 36zero/wearable'
      echo '          ww fh               # work with 36zero/hardware'
      echo '          ww fm               # work with 36zero/manufacturing'
      echo '          ww fp               # work with 36zero/36zero-project'
      echo '          ww fr               # work with 36zero release building'
      echo '          ww f@               # work with fuseAware/@legacy'
      echo '          ww fs               # work with fuseAware/study'
      echo '          ww fx               # work with Floxxo/floxxo'
      echo '          ww j                # work with Jupyter'
      echo '          ww jl               # work with Neural jupyter lab'
      echo '          ww m                # work with Matlab'
      echo '          ww mc               # work with motor cycle solution display'
      echo '          ww nd               # work with Neural/neurotron-develop'
      echo '          ww np               # work with Numenta/htm-play'
      echo '          ww nh               # work with Numenta/htm-study'
      echo '          ww np               # work with Numenta/htm-play'
      echo '          ww s                # work with Study'
      echo '          ww t                # work with Train'
      echo '          ww x                # work with Excellent/lan-driver'
      echo '          ww z                # work with Zstuff'
      echo '          ww zb               # work with Zstuff/blucino'
      echo '          ww zt               # work with Zstuff/traffic'
      echo '          ww zp               # work with zephyr-pico'
      echo '          ww Z                # work with Zephyr'
      echo ''
      echo '          ww t1               # setup terminal 1'
      echo '          ww t2               # setup terminal 2'
      echo '          ww t3               # setup terminal 3'
      echo ''
      echo '   multiple args'
      echo '          ww 1 5              # change to 01-.../05-...'
      echo '          ww .. ..            # change to ../..'

   fi

#===============================================================================
# check for 2-digit arg
#===============================================================================

   DIGITS='0 1 2 3 4 5 6 7 8 9'
   PREFIX=''
   for DIGIT in $DIGITS
   do
      if [ "$1" == "$DIGIT" ]; then
         PREFIX=0
      fi
   done

   DIGITS='00 01 02 03 04 05 06 07 08 09 10 11 12 13 14 15 16 17 18 19 20'

   if [ -d $PREFIX$1-* ]; then
      ec -g $PREFIX$1-*
      cd $PREFIX$1-*
      ww .
   else
      for DIGIT in $DIGITS
      do
         if [ "$PREFIX$1" == "$DIGIT" ]; then
            cd ../$DIGIT-*
            source ww.sh .
         fi
      done
   fi

   if [ "$*" == ".." ]; then
      cd ..
      ww .
   fi

#===============================================================================
# ww command without args (cd to $WORK)
#===============================================================================

   if [ "$*" == "" ]; then
      cd $WORK
      ec -g "working in: $WORK"
      ls
   fi

#===============================================================================
# ww . (set WORK environment variable to match current directory)
#===============================================================================

   if [ "$*" == "." ]; then
      WORK=`pwd`
      ec -y "current working directory: $WORK"
      ls
   fi

#===============================================================================
# AI/Semantic environment
#===============================================================================

   if [ "$*" == "ai" ]; then
      cd $GIT/Semantic
      bgr -r
   fi

#===============================================================================
# Altium environment
#===============================================================================

   if [ "$*" == "ae" ]; then
      cd $GIT/Altium/Lib/altium-lib-etc
      bgr -r
   fi

   if [ "$*" == "al" ]; then
      cd $GIT/Altium/Lib/altium-lib-bnx
      bgr -r
   fi

   if [ "$*" == "ap" ]; then
      cd $GIT/Altium/Play/altium-playground
      bgr -r
   fi

#===============================================================================
# BLUCO environment
#===============================================================================

   BLUCOSW=$GIT/Bluco/bluco-software
   BLUCOHW=$GIT/Bluco/bluco-hardware
   BLUCOMF=$GIT/Bluco/bluco-manufacturing

   if [ "$*" == "br" ]; then
      cd $GIT/Train/bluetrain
      bgr -b
   fi

   if [ "$*" == "bs" ]; then
      cd $BLUCOSW
      bgr -b
   fi

# Bluco Hardware

   if [ "$*" == "bh" ]; then
      cd $BLUCOHW
      bgr -m
   fi

# Bluco Project

   if [ "$*" == "bpj" ]; then
      cd $GIT/Bluco/bluco-project
      bgr -m
   fi

# Bluco Manufacturing

   if [ "$*" == "bm" ]; then
      cd $BLUCOMF
      bgr -m
   fi

#===============================================================================
# BLUCCINO environment
#===============================================================================

   if [ "$*" == "bl" ]; then
      cd $BLUCCINO/bluccino-develop/lessons
      bgr -b
   fi

   if [ "$*" == "pr" ]; then
      cd $BLUCCINO/principles
      bgr -g
   fi

   if [ "$*" == "bq" ]; then
      cd $BLUCCINO/tutorial/quicktour
      bgr -b
   fi

#===============================================================================
# BLUCCINO training
#===============================================================================

   if [ "$*" == "bt" ]; then
      cd $BLUCCINO/bluccino-tutorial
      bgr -b
   fi

#===============================================================================
# BLUCCINO develop
#===============================================================================

   if [ "$*" == "bd" ]; then
      cd $BLUCCINO/bluccino-develop
      bgr -b
   fi

   if [ "$*" == "bdb" ]; then
      cd $BLUCCINO/bluccino-develop/ble
      bgr -b; pwd; ls
   fi

   if [ "$*" == "bdl" ]; then
      cd $BLUCCINO/bluccino-develop/lessons
      bgr -b; pwd; ls
   fi

   if [ "$*" == "bdo" ]; then
      cd $BLUCCINO/bluccino-docker
      bgr -b; pwd; ls
   fi

   if [ "$*" == "bds" ]; then
      cd $BLUCCINO/bluccino-develop/samples
      bgr -b; pwd; ls
   fi

   if [ "$*" == "bdz" ]; then
      cd $BLUCCINO/bluccino-develop/zephyr
      bgr -b; pwd; ls
   fi

#===============================================================================
# Bluccino Doc
#===============================================================================

   if [ "$*" == "bdoc" ]; then
      cd $BLUCCINO/bluccino-doc
      bgr -b
   fi

#===============================================================================
# BLUCCINO Pico & Zephyr Pico
#===============================================================================

   if [ "$*" == "bp" ]; then
      cd $GIT/Bluccino/bluccino-pico
      bgr -m
   fi

   if [ "$*" == "zp" ]; then
      cd $BLUCCINO/zephyr-pico
      bgr -y
   fi

#===============================================================================
# Conda
#===============================================================================

   if [ "$*" == "c" ]; then
      cd $CONDA
      bgr -r
   fi

#===============================================================================
# Docker
#===============================================================================

   if [ "$*" == "do" ]; then
      cd $GIT/Docker
      bgr -c
   fi

#===============================================================================
# fuseAware
#===============================================================================

   FA360=$GIT/36zero
   FARELEASE=$FA360/libraries/"release/b1.0.1(FOTA)/4_Doc"

   if [ "$*" == "f" ]; then
      cd $FA360
      bgr -r
   fi

   if [ "$*" == "fb" ]; then
      cd $FA360/beacon
      bgr -r
   fi

   if [ "$*" == "fg" ]; then
      cd $FA360/gateway
      bgr -r
   fi

   if [ "$*" == "fl" ]; then
      cd $FA360/libraries
      bgr -r
   fi

   if [ "$*" == "fw" ]; then
      cd $FA360/wearable
      bgr -r
   fi

   if [ "$*" == "fh" ]; then
      cd $FA360/hardware
      bgr -r
   fi

   if [ "$*" == "fm" ]; then
      cd $FA360/manufacturing
      bgr -r
   fi

   if [ "$*" == "fp" ]; then
      cd $FA360/36zero-project
      bgr -k
   fi

   if [ "$*" == "f@" ]; then
      cd $FA/@legacy
      bgr -r
   fi

   if [ "$*" == "fr" ]; then
      cd $FARELEASE
      bgr -r
   fi

   if [ "$*" == "fs" ]; then
      cd $FA360/study
      bgr -g
   fi

#===============================================================================
# Floxxo
#===============================================================================

   FLOXXO=$GIT/Floxxo/floxxo

   if [ "$*" == "fx" ]; then
      cd $FLOXXO
      bgr -g
   fi

#===============================================================================
# DOC environment
#===============================================================================

   if [ "$*" == "d" ]; then
      cd $GIT/Environment/doc
      bgr -y
   fi

#===============================================================================
# Bluco Hardware
#===============================================================================

   if [ "$*" == "h" ]; then
      cd $BLUCOHW
      bgr -k
   fi

# Environment

   if [ "$*" == "e" ]; then
      cd $GIT/Environment/usr
      bgr -k
   fi

#===============================================================================
# Excellent
#===============================================================================

   if [ "$*" == "x" ]; then
      cd $GIT/Excellent/lan-driver
      bgr -b
   fi

#===============================================================================
# STUDY environment
#===============================================================================

   if [ "$*" == "s" ]; then
      cd $STUDY
      bgr -g
   fi

#===============================================================================
# Jupyter environment
#===============================================================================

   if [ "$*" == "j" ]; then
      cd $GIT/Semantic/Jupyter
      bgr -m
   fi

#===============================================================================
# Matlab environment
#===============================================================================

   if [ "$*" == "m" ]; then
      cd $GIT/Matlab/matlab-m
      bgr -k
   fi

#===============================================================================
# Motor cycle solution display environment
#===============================================================================

   if [ "$*" == "mc" ]; then
      cd $GIT/Display/mc-solution-display
      bgr -k
   fi

#===============================================================================
# Neural
#===============================================================================

NEURAL=$GIT/Neural

if [ "$*" == "jl" ]; then
   cd $NEURAL/carabao-utils
   bgr -r
   source go
   cd jupyter
   jupyter lab
fi

if [ "$*" == "nc" ]; then
   cd $NEURAL/carabao-utils
   bgr -r
fi

if [ "$*" == "nd" ]; then
   cd $NEURAL/neurotron-develop
   bgr -b
fi

if [ "$*" == "nh" ]; then
   cd $NEURAL/htm-study
   bgr -y
fi

if [ "$*" == "np" ]; then
   cd $NEURAL/htm-play
   bgr -y
fi

#===============================================================================
# Train
#===============================================================================

   if [ "$*" == "t" ]; then
      cd $GIT/Train/bluetrain
      bgr -b
   fi

# Zephyr demo environment

   if [ "$*" == "z" ]; then
      cd $ZSTUFF
      bgr -y
   fi

# Zephyr demo environment, bluccino demos

   if [ "$*" == "zb" ]; then
      cd $ZSTUFF/bluccino
      bgr -b
   fi

# Zephyr demo environment, traffic demos

   if [ "$*" == "zt" ]; then
      cd $ZSTUFF/traffic
      bgr -r
   fi

# Zephyr environment

   if [ "$*" == "Z" ]; then
      cd $ZEPHYR/zephyr
      bgr -y
      gis
   fi

# Terminal 1

   if [ "$*" == "t1" ]; then
      bgr -bk
      tel -1
   fi

# Terminal 2

   if [ "$*" == "t2" ]; then
      bgr -gk
      tel -2
   fi

# Terminal 3

   if [ "$*" == "t3" ]; then
      bgr -rk
      tel -3
   fi

#===============================================================================
# ww $* (set WORK environment variable to match existing directory)
#===============================================================================

   if [ -d "$*" ] && [ "$*" != "." ] && [ "$*" != ".." ]; then
      cd "$*"
      WORK=`pwd`
      ec -y "current working directory: $WORK"
      ls
   fi

#===============================================================================
# Is there more to do?
# - usage: ww .. ..
#          ww 1 5     # change to 01-.../05-...
#===============================================================================

	if [ "$2" != "" ]; then
    shift
    source ww.sh $*  # continue processing
  fi
