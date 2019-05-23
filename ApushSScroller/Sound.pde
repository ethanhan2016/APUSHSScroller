import ddf.minim.*;

class Sound {
  Minim minim;
  AudioPlayer[] themePlayers = new AudioPlayer[2];
  AudioPlayer[] gunSounds = new AudioPlayer[3];
  AudioPlayer[] hitSounds = new AudioPlayer[2];;
  
  Sound(ApushSScroller apushsscroller) {
    minim = new Minim(apushsscroller);
    hitSounds[0] = minim.loadFile("sounds/hurt.mp3");
    hitSounds[1] = minim.loadFile("sounds/death.mp3");
    themePlayers[0] = minim.loadFile("sounds/main.mp3");
    themePlayers[0].setGain(-25);
    themePlayers[1] = minim.loadFile("sounds/boss.mp3");
    for (int i = 0; i < 3; i++) {
      gunSounds[i] = minim.loadFile("sounds/gun" + nf(i, 4) + ".mp3");
    }
    themePlayers[0].loop();
  }
}
