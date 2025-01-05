float[][] map = new float[100][100];
float tileSx, tileSy;
float transfer = 0.05;

//Settings:
int smoothing = 32;
int heightValue = 1200;

//Heights:
float mountains = 45;
float hills = 40;
float forests = 18;
float swamp = 15;
float gras = 12;
float beach = 5;
float sea = 0;

color mountainsColor = #FFFFFF;
color hillsColor = #AFAFAF;
color forestsColor = #115200;
color swampsColor = #253421;
color grasColor = #38FF03;
color beachColor = #FEFF03;
color seaColor = #03A0FF;


void setup() {
  size(600, 600);
  noSmooth();
  noStroke();
  frameRate(1000);
  run();
  
  fill(#FF6F00);
  textSize(20);
  text("Press Key to create", 10, 20);
}

void draw() {}

void mouseReleased() {
  println(map[round(mouseX/tileSx)][round(mouseY/tileSy)]);
}

void keyReleased() {
  run();
}

void drawCell(int x, int y) {
  float curTemp = map[x][y];

  //Colors
  if (curTemp >= mountains) {
    fill(mountainsColor);
  } else if (curTemp <= mountains && curTemp >= hills) {
    fill(hillsColor);
  } else if (curTemp <= hills && curTemp >= forests) {
    fill(forestsColor);
  } else if (curTemp <= forests && curTemp >= swamp) {
    fill(swampsColor);
  } else if (curTemp <= swamp && curTemp >= gras) {
    fill(grasColor);
  } else if (curTemp <= gras && curTemp >= beach) {
    fill(beachColor);
  } else if (curTemp <= beach) {
    fill(seaColor);
  }

  //Draw Cell
  rect(tileSx*x, tileSy*y, tileSx, tileSy);
}

void run() {
  println("Loading...");

  initGame();

  for (int i = 0; i<smoothing; i++) {
    progress();
  }

  println("Done");
}

void progress() {
  for (int i = 0; i<map.length; i++) {
    for (int j = 0; j<map[i].length; j++) {
      simulate(i, j);
      drawCell(i, j);
    }
  }
}


void initGame() {
  tileSx = width/map.length;
  tileSy = height/map[0].length;

  for (int i = 0; i<map.length; i++) {
    for (int j = 0; j<map[i].length; j++) {
      if (i == 0 || i == map.length-1) {
        map[i][j] = -heightValue*2;
      } else if (j == 0 || j == map[i].length-1) {
        map[i][j] = -heightValue*2;
      } else {
        map[i][j] = int(random(heightValue))-heightValue/2;
      }
    }
  }
}

void simulate(int x, int y) {
  //Simulation
  float tempTransData = transfer*map[x][y];
  int i = 0;


  if (x != 0 && y != map[0].length-1) {
    setCellValue(x-1, y+1, map[x-1][y+1]+tempTransData); 
    i++;
  }

  if (x != 0 && y != map[0].length-1) {
    setCellValue(x-1, y, map[x-1][y]+tempTransData); 
    i++;
  }

  if (x != 0 && y != 0) {
    setCellValue(x-1, y-1, map[x-1][y-1]+tempTransData); 
    i++;
  }

  if (x != 0 && y != map[0].length-1) {
    setCellValue(x, y+1, map[x][y+1]+tempTransData); 
    i++;
  }

  if (x != 0 && y != 0) {
    setCellValue(x, y-1, map[x][y-1]+tempTransData); 
    i++;
  }

  if (x != map.length-1 && y != map[0].length-1) {
    setCellValue(x+1, y+1, map[x+1][y+1]+tempTransData); 
    i++;
  }

  if (x != map.length-1 && y != map[0].length-1) {
    setCellValue(x+1, y, map[x+1][y]+tempTransData); 
    i++;
  }

  if (x != map.length-1 && y != 0) {
    setCellValue(x+1, y-1, map[x+1][y-1]+tempTransData); 
    i++;
  }

  map[x][y] -= transfer*map[x][y] * i;
}

void setCellValue(int x, int y, float newValue) {
  map[x][y] = newValue;
}
