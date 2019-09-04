int columns, rows;
int scaleValue = 40;
int terrainWidth = 2000;
int terrainHeight = 1600;

float moveSpeed = 0;

float[][] terrainZaxis;

void setup() {
  size(1000, 1000, P3D); // canvas size would be 1000 * 1000 and put in 3D world
  initializer();// set the the needed values once
}


void draw() {
  perlinNoise();// keep on going forever
}

void initializer()
{
  columns = terrainWidth / scaleValue; // column would depend on the how big we want the width of the terrainZaxis to be and the how big we want our vertexes
  rows = terrainHeight/ scaleValue; // column would depend on the how big we want the height of the terrainZaxis to be and the how big we want our vertexes
  terrainZaxis = new float[columns][rows]; //make a two dimensional array as big as the colums and rows to keep the z-coordinate values
}

void perlinNoise(){

  noiseValue(); // get the moving value and calculate the noise value (z-coordinates)

  background( map(120, 0, mouseX+1, 0, 225) );// fun mapping, position of mouse on the x cordinate dictates the colour of the backgorund

  translate(width/2, height/2+50);// translate the whole terrainZaxis to the middle of the canvas
  rotateX(PI/3);// rotate the terrainZaxis 60 degrees
  translate(-terrainWidth/2, -terrainHeight/2); // translate the terrainZaxis to the top left of the canvas
  
  // noStroke(); //Remove the vertex strokes from the triangle strips
  //random(-100, 100)

  PImage img = loadImage("grass.png"); // load the texture
  for (int y = 0; y < rows-1; y++) {
    beginShape(TRIANGLE_STRIP); // we want to draw traingle strips
    texture(img); // apply the texture
    for (int x = 0; x < columns; x++) {
      //draw two triangle vertexes to look like a rectangle or square
      //using 256 for the UV mapping because the image is on a 256 x 256pixel range.
      vertex(x*scaleValue, y*scaleValue, terrainZaxis[x][y], 265/columns * x, 256/rows * (y));
      vertex(x*scaleValue, (y+1)*scaleValue, terrainZaxis[x][y+1], 256/columns * x, 256/rows * (y+1));
    }
    endShape();// stop applying triangle strip to vertexes
  } 

}

void noiseValue()
{
   
  moveSpeed -= 0.03;// how fast it looks like a person is moving forward

  //set the y value to the moveSpeed to make it look like we are moving upwards but 
  //what is really happening is that the terrainZaxis bumps are changing on the y coordinates at the moveSpeed
  float yoffset = moveSpeed;
  for (int y = 0; y < rows; y++) {
    float xoffset = 0;
    for (int x = 0; x < columns; x++) {
      terrainZaxis[x][y] = map(noise(xoffset, yoffset), 0, 1, -90, 90);// get a noise value withing a little range and map it between -90 and 90 for big bumps
      xoffset += 0.2; 
    }
    yoffset += 0.2;
  }

}