Live.Library = [
  {
    name: "Video Portrait"
    code: """WEBCAM.init();

int r;
float c;

var ctx;

PImage frame;
PImage frames[];

int LENGTH = 120;

void setup () {
  size(460, 400); // don't change this
  background(0);
  noStroke();

  ctx = externals.context;

  c = 0.0;
  w = 10;

  frames = new PImage[LENGTH];

  frameRate(24);
}

int save_frame = 0, play_frame = 0;

void draw() {
  // your code here!

  if (keyPressed) {
    ctx.drawImage(WEBCAM.video, 0, 0);
    frames[save_frame] = get();
    save_frame = (save_frame + 1) % LENGTH;
  } else {
    if (frames[play_frame]) {
      image(frames[play_frame], 0, 0);
      play_frame = (play_frame + 1) % LENGTH;
    } else {
      play_frame = 0;
    }
  }
}
    """
  },
  {
    name: "Wolfram 1D Cellular Automata"
    code: """int WIDTH = 460;
int RULESET = 225; // 0 - 255
int STEP = 8;
boolean FADE = true;

////////// 1 dimensional cellular automata

int row[], next_row[];
int y;
int TRUTH = 1;
color dead_color = color(0, 0, 100);
color live_color = color(255, 0 ,0);

void setup() {
  size(WIDTH, WIDTH);
  noStroke();

  row = new int[width];
  next_row = new int[width];

  randomize_row();
  y = 0;
  background(0);
}

void randomize_row() {
  // start row with noise
  for (int x=0; x < width; x++) {
    // noise
    row[x] = floor(random(0, 2)) == 1 ? TRUTH : 0;
  }
}

int get_int_from_bits(int a, int b, int c) {
  return (a * 4) + (b * 2) + c;
}

int apply_ruleset(int[] r, int i) {
  int a, b, c;

  if (i == 0) {
    a = width - 1;
    b = i;
    c = i + 1;
  } else if (i == width - 1) {
    a = i - 1;
    b = i;
    c = 0;
  } else {
    a = i - 1;
    b = i;
    c = i + 1;
  }

  // convert indecies to values
  a = r[a];
  b = r[b];
  c = r[c];

  int rule_pattern = get_int_from_bits(a, b, c);

  int result = (RULESET & int(pow(2, rule_pattern)));

  // increment by truth value or decrement by 1
  return result >= 1 ? 1 : 0;
}

void draw() {
  // loop to draw and evaluate

  /// DRAW

  for (int x=0; x < WIDTH; x++) {
    // draw each pixel on one line
    fill(row[x] == 1 ? live_color : dead_color, FADE ? 50 : 255);
    rect(x * STEP, y, STEP, STEP);

    if (x * STEP > width) break;

    // set(x, y, row[x] == 1 ? live_color : dead_color);
  }

  /// UPDATE

  // generate next generation
  for (int x=0; x < WIDTH; x++) {
    next_row[x] = apply_ruleset(row, x);
  }

  // replace current gen with updated gen
  for (int x=0; x < WIDTH; x++) {
    row[x] = next_row[x];
  }

  // step down
  y = (y + STEP);

  if (y >= height) {
    randomize_row();
    y = 0;
  }
}
    """
  },
  {
    name: 'Heartbeat'
    code: """int r;
float c;

void setup () {
  size(460, 400); // don't change this
  background(0);
  noStroke();

  c = 0.0;
  w = 10;
}

void draw() {
  // your code here!
  fill(0, 10);
  rect(0, 0, width, height);

  fill(200, 0, 40);
  r = (height/2) + 100 * sin(c);
  ellipse(width/2, height/2, r, r);
  c += 0.1;
}
    """
  },
  {
    name: "Hue"
    code: """
/**
 * Hue.
 *
 * Hue is the color reflected from or transmitted through an object
 * and is typically referred to as the name of the color (red, blue, yellow, etc.)
 * Move the cursor vertically over each bar to alter its hue.
 */

int barWidth = 20;
int lastBar = -1;

void setup()
{
  size(460, 400);
  colorMode(HSB, height, height, height);
  noStroke();
  background(0);
}

void draw()
{
  int whichBar = mouseX / barWidth;
  if (whichBar != lastBar) {
    int barX = whichBar * barWidth;
    fill(mouseY, height, height);
    rect(barX, 0, barWidth, height);
    lastBar = whichBar;
  }
}
    """
  },
  {
    name: "Wave Gradient"
    code: """
/**
 * Wave Gradient
 * by Ira Greenberg.
 *
 * Generate a gradient along a sin() wave.
 */

float angle = 0;
float px = 0, py = 0;
float amplitude = 30;
float frequency = 0;
float fillGap = 2.5;
color c;

void setup() {
  size(640, 360);
  background(200);
  noLoop();
}

void draw() {
  for (int i =- 75; i < height+75; i++){
    // Reset angle to 0, so waves stack properly
    angle = 0;
    // Increasing frequency causes more gaps
    frequency+=.002;
    for (float j = 0; j < width+75; j++){
      py = i + sin(radians(angle)) * amplitude;
      angle += frequency;
      c =  color(abs(py-i)*255/amplitude, 255-abs(py-i)*255/amplitude, j*(255.0/(width+50)));
      // Hack to fill gaps. Raise value of fillGap if you increase frequency
      for (int filler = 0; filler < fillGap; filler++){
        set(int(j-filler), int(py)-filler, c);
        set(int(j), int(py), c);
        set(int(j+filler), int(py)+filler, c);
      }
    }
  }
}
    """
  },
  {
    name: "Empathy"
    code: """/**
  Don't move too fast - you might scare it. Click to forgive and forget.

  http://kylemcdonald.net/
*/

int n = 5000; // number of cells
float bd = 37; // base line length
float sp = 0.004; // rotation speed step
float sl = .97; // slow down rate

Cell[] all = new Cell[n];

class Cell{
  int x, y;
  float s = 0; // spin velocity
  float c = 0; // current angle
  Cell(int x, int y) {
    this.x=x;
    this.y=y;
  }

  void sense() {
    if(pmouseX != 0 || pmouseY != 0)
      s += sp * det(x, y, pmouseX, pmouseY, mouseX, mouseY) / (dist(x, y, mouseX, mouseY) + 1);
    s *= sl;
    c += s;
    float d = bd * s + .001;
    line(x, y, x + d * cos(c), y + d * sin(c));
  }
}

void setup(){
  size(300, 300, P2D);
  stroke(0, 0, 0, 20);
  for(int i = 0; i < n; i++){
    float a = i + random(0, PI / 9);
    float r = ((i / (float) n) * (width / 2) * (((n-i) / (float) n) * 3.3)) + random(-3,3) + 3;
    all[i] = new Cell(int(r*cos(a)) + (width/2), int(r*sin(a)) + (height/2));
  }
}

void draw() {
  background(255);
  for(int i = 0; i < n; i++)
    all[i].sense();
}

void mousePressed() {
  for(int i=0;i<n;i++)
    all[i].c = 0;
}

float det(int x1, int y1, int x2, int y2, int x3, int y3) {
  return (float) ((x2-x1)*(y3-y1) - (x3-x1)*(y2-y1));
}
    """
  }

]
