int Length = 400;
int Max_Human = 20;
int robber = 15;
int startx = int(random(Length));
int starty = int(random(Length));

 //creat wall
int rect_pointx = 100;
int rect_pointy = 100;
int rect_lengthx = int(random(50,200));
int rect_lengthy = int(random(50,200));
int en_pointx = 250;
int en_pointy = 250;
int en_lengthx = int(random(50,200));
int en_lengthy = int(random(50,200));


int[][] MAP = new int[Length][Length];

Human_class[] Human = new Human_class[Max_Human];

void setup(){
  colorMode(RGB);
  size(Length, Length+100);
  background(0);
  frameRate(30);
  PFont font = loadFont("AgencyFB-Bold-40.vlw");
  textFont(font);
  
  
   //creat Human
   //player
   for(int i=0; i<1; i++){
    int k1 = 4;  //player
    int k2 = 30;
    int k3 = 30;
    /*
    int k4 = 1 - int(random(3)); //xvel
    if(k4==0) k4 = 1;
    int k5 = 1 - int(random(3));  //yvel
    if(k5==0) k5 = 1;
    */
    int k4 = 0;
    int k5 = 0;
    Human[i] = new Human_class(k1, k2, k3, k4, k5);
  }
   
   //robber
  for(int i=1; i<robber; i++){
    int k1 = 1;  //tousou
    int k2 = 0;
    int k3 = 0;
    int select_spone = int(random(3));
    if(select_spone == 0){
      k2 = int(random(90)); //x
      k3 = int(random(340)); //y
    }
    else if(select_spone == 1){
      k2 = int(random(100, Length));
      k3 = int(random(90));
    }
    else{
      k2 = int(random(360,Length));
      k3 = int(random(100,Length));
    }
    /*
    int k4 = 1 - int(random(3)); //xvel
    if(k4==0) k4 = 1;
    int k5 = 1 - int(random(3));  //yvel
    if(k5==0) k5 = 1;
    */
    int k4 = int(random(5));
    int k5 = 0;
    Human[i] = new Human_class(k1, k2, k3, k4, k5);
  }
  
  //poli
  for(int i=robber; i<Max_Human; i++){
    int k1 = 2;  //oni
    int k2 = int(random(100,225));
    int k3 = int(random(360,Length));
    /*
    int k4 = 1 - int(random(3)); //xvel
    if(k4==0) k4 = 1;
    int k5 = 1 - int(random(3));  //yvel
    if(k5==0) k5 = 1;
    */
    int k4 = int(random(5));
    int k5 = 0;
    Human[i] = new Human_class(k1, k2, k3, k4, k5);
  }
  
  //MAP
  for(int i=0; i<Length; i++){
    for(int j=0; j<Length; j++){
      MAP[i][j] = 0;
    }
  }
  
   //rect
  for(int i=rect_pointx; i<rect_pointx + rect_lengthx; i++){
    for(int j=rect_pointy; j<rect_pointy + rect_lengthy; j++){
      MAP[i][j] = 3;
    }
  }
   //en
  for(int i=int(en_pointx-en_lengthx/2); i<int(en_pointx+en_lengthx/2); i++){
    for(int j=int(en_pointy-en_lengthy/2); j<int(en_pointy+en_lengthy/2); j++){
      MAP[i][j] = 3;
    }
  }
  
  
}


void draw(){
  makeground();
  
  //wall
  noStroke();
  fill(255,0,0);
  rect(rect_pointx, rect_pointy, rect_lengthx, rect_lengthy);
  ellipse(en_pointx, en_pointy, en_lengthx, en_lengthy);
  
  
  //draw Human
   for(int j=0; j<Max_Human; j++){
    if(Human[j].type != 0){
    Human[j].timer++;
    //move with clock in body on animation
    Human[j].draw();
    }
  }
  
  //move Human
  
  for(int j=0; j<Max_Human; j++){
    if(Human[j].type != 0){
      Human[j].drive();
    }
  }
  
  //college
  for(int j=0; j<Max_Human; j++){
    if(Human[j].type != 0){
      Human[j].coll();
    }
  }
  
  //escape and chase
  for(int j=0; j<Max_Human; j++){
    if(Human[j].type == 1){
      Human[j].escape();
    }
    if(Human[j].type == 2){
      Human[j].chase();
    }
    Human[j].coll();
  }
  
  //judge
  for(int j=0; j<Max_Human; j++){
    if(Human[j].type == 1){
      if(MAP[Human[j].xpos][Human[j].ypos] == 2){
        Human[j].type = 0;
        robber--;
      }
    }
    else if(Human[j].type == 4){
      if(MAP[Human[j].xpos][Human[j].ypos] == 2){
        Human[j].type = 0;
        robber--;
        gameoverGround();
      }
    }
  }
  
  
  //text
  if(Human[0].type != 0){
  fill(255);
  text("number of robber = " + robber, 10, Length+50);
  }
  else{
    gameoverGround();
  }
}



class Human_class{
  int xpos;  
  int ypos;
  int type;
  int xvel;
  int yvel;
  int timer;
  int select_vel;
  
  Human_class(int c, int xp, int yp, int direction, int t){
    xpos = xp;
    ypos = yp;
    type = c;
    select_vel = direction;
    timer = t;
  }
  
  void draw(){
    if(type == 1){
    smooth();
    noStroke();
    fill(0, 255, 0);
    
    //animation
    int time = timer % 5;
    switch(time){
      case 0:
        ellipse(xpos, ypos, 6, 6);  //head
        rect(xpos-3, ypos+3, 6, 5); //body
        rect(xpos-3, ypos+8, 3, 5); //left leg
        rect(xpos-4, ypos+3, 2, 5); //left arm
        rect(xpos+2, ypos+3, 2, 5); //right arm
        break;
        
      case 1:
        ellipse(xpos, ypos, 6, 6);
        rect(xpos-3, ypos+3, 6, 5);
        rect(xpos-3, ypos+8, 3, 4);
        rect(xpos, ypos+8, 3, 1);
        break;
      case 2:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,3);
        rect(xpos,ypos+8,3,3);
        break;
      case 3:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,1);
        rect(xpos,ypos+8,3,4);
        break;
      case 4:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos,ypos+8,3,5);
        rect(xpos-4,ypos+3,2,5);
        rect(xpos+2,ypos+3,2,5);
        break;
    
    }
  }
  
  if(type == 2){
    smooth();
    noStroke();
    fill(0);
    
    //animation
    int time = timer % 5;
    switch(time){
      case 0:
        ellipse(xpos, ypos, 6, 6);  //head
        rect(xpos-3, ypos+3, 6, 5); //body
        rect(xpos-3, ypos+8, 3, 5); //left leg
        rect(xpos-4, ypos+3, 2, 5); //left arm
        rect(xpos+2, ypos+3, 2, 5); //right arm
        break;
        
      case 1:
        ellipse(xpos, ypos, 6, 6);
        rect(xpos-3, ypos+3, 6, 5);
        rect(xpos-3, ypos+8, 3, 4);
        rect(xpos, ypos+8, 3, 1);
        break;
      case 2:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,3);
        rect(xpos,ypos+8,3,3);
        break;
      case 3:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,1);
        rect(xpos,ypos+8,3,4);
        break;
      case 4:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos,ypos+8,3,5);
        rect(xpos-4,ypos+3,2,5);
        rect(xpos+2,ypos+3,2,5);
        break;
      
    }
    
    }
     if(type == 4){
    smooth();
    noStroke();
    fill(0, 0, 255);
    
    //animation
    int time = timer % 5;
    switch(time){
      case 0:
        ellipse(xpos, ypos, 6, 6);  //head
        rect(xpos-3, ypos+3, 6, 5); //body
        rect(xpos-3, ypos+8, 3, 5); //left leg
        rect(xpos-4, ypos+3, 2, 5); //left arm
        rect(xpos+2, ypos+3, 2, 5); //right arm
        break;
        
      case 1:
        ellipse(xpos, ypos, 6, 6);
        rect(xpos-3, ypos+3, 6, 5);
        rect(xpos-3, ypos+8, 3, 4);
        rect(xpos, ypos+8, 3, 1);
        break;
      case 2:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,3);
        rect(xpos,ypos+8,3,3);
        break;
      case 3:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos-3,ypos+8,3,1);
        rect(xpos,ypos+8,3,4);
        break;
      case 4:
        ellipse(xpos,ypos,6,6);
        rect(xpos-3,ypos+3,6,5);
        rect(xpos,ypos+8,3,5);
        rect(xpos-4,ypos+3,2,5);
        rect(xpos+2,ypos+3,2,5);
        break;
    
    }
  }
    
  }
    
  void drive(){
    MAP[xpos][ypos] = 0;
    if(type == 1 || type == 2){
    if(random(100) < 5){
      select_vel = int(random(5));
    }
    }
      if(select_vel == 0){
        xvel = 0;
        yvel = 0;
      }
      else if(select_vel == 1){
        xvel = 1;
        yvel = 0;
      }
      else if(select_vel == 2){
        xvel = -1;
        yvel = 0;
      }
      else if(select_vel == 3){
        xvel = 0;
        yvel = 1;
      }
      else{
        xvel = 0;
        yvel = -1;
      }
    
    
    xpos = (xpos + xvel + Length) % Length;
    ypos = (ypos + yvel + Length) % Length;
    MAP[xpos][ypos] = type;
  }
  
  void coll(){
    int action = 0;
    for(int r=0; r<11; r++){
      for(int s=0; s<366; s=s+5){
        
        int i = int(r*cos(radians(s)));
        int j = int(r*sin(radians(s)));
        
        if(MAP[(xpos+i+Length)%Length][(ypos+j+Length)%Length] == 3){
          MAP[xpos][ypos] = 0;
          if((i>0) && (action == 0)){
            select_vel = 2;
            xpos = (xpos - 1 + Length) % Length;
            action = 1;
          }
          if((i<0) && (action == 0)){
            select_vel = 1;
            xpos = (xpos + 1 + Length) % Length;
            action = 1;
          }
          if((j>0) && (action == 0)){
            select_vel = 4;
            ypos = (ypos - 1 + Length) % Length;
            action = 1;
          }
          if((j<0) && (action == 0)){
            select_vel = 3;
            ypos = (ypos + 1 + Length) % Length;
            action = 1;
          }
        }
        if(action == 1){
          break;
        }
      }
    }
    MAP[xpos][ypos] = type;
 
  }
  
  void escape(){
    int action = 0;
    for(int r = 0; r<201; r++){
      for(int s=0; s<366; s= s+5){
        
        int i = int(r*cos(radians(s)));
        int j = int(r*sin(radians(s)));
        
        if(MAP[(xpos+i+Length)%Length][(ypos+j+Length)%Length] == 2){
          MAP[xpos][ypos] = 0;
            if((i>0) && (action == 0)){
              select_vel = 2;
              xpos = (xpos - 1 + Length) % Length;
              action = 1;
            }
            if((i<0) && (action == 0)){
              select_vel = 1;
              xpos = (xpos + 1 + Length) % Length;
              action = 1;
            }
            if((j>0) && (action == 0)){
              select_vel = 4;
              ypos = (ypos - 1 + Length) % Length;
              action = 1;
            }
            if((j<0) && (action == 0)){
              select_vel = 3;
              ypos = (ypos + 1 + Length) % Length;
              action = 1;
            }
        }
        if(action == 1){
          break;
        }
      }
    }
    MAP[xpos][ypos] = 1;
  }
  
  void chase(){
    int action = 0;
    for(int r = 0; r<100; r++){
      for(int s=0; s<366; s= s+5){
        
        int i = int(r*cos(radians(s)));
        int j = int(r*sin(radians(s)));
        
        if(MAP[(xpos+i+Length)%Length][(ypos+j+Length)%Length] == 1 || MAP[(xpos+i+Length)%Length][(ypos+j+Length)%Length] == 4){
          MAP[xpos][ypos] = 0;
            if((i>0) && (action == 0)){
              select_vel = 1;
              xpos = (xpos + 2 + Length) % Length;
              action = 1;
            }
            if((i<0) && (action == 0)){
              select_vel = 2;
              xpos = (xpos - 2 + Length) % Length;
              action = 1;
            }
            if((j>0) && (action == 0)){
              select_vel = 3;
              ypos = (ypos + 2 + Length) % Length;
              action = 1;
            }
            if((j<0) && action == 0){
              select_vel = 4;
              ypos = (ypos - 2 + Length) % Length;
              action = 1;
            }
        }
        if(action == 1){
          break;
        }
      }
    }
    MAP[xpos][ypos] = 2;
  }
    
}




void makeground(){
  fill(128);
  rect(0,0,Length,Length);
  fill(0);
  rect(0,Length,Length,100);
}

void gameoverGround(){
  fill(0);
  rect(0,0,width,height);
  fill(255,0,0);
  text("GAME OVER", width/2-120, height/2);
  
}

void keyPressed(){
  MAP[Human[0].xpos][Human[0].ypos] = 0;
  if(key == CODED){
    if(keyCode == UP){
      Human[0].select_vel = 4;
      Human[0].ypos = (Human[0].ypos - 1 + Length) % Length;
    }
    else if(keyCode == DOWN){
      Human[0].select_vel = 3;
      Human[0].ypos = (Human[0].ypos + 1 + Length) % Length;
    }
    else if(keyCode == RIGHT){
      Human[0].select_vel = 1;
      Human[0].xpos = (Human[0].xpos + 1 + Length) % Length;
    }
    else if(keyCode == LEFT){
      Human[0].select_vel = 2;
      Human[0].xpos = (Human[0].xpos - 1 + Length) % Length;
    }
  }
  MAP[Human[0].xpos][Human[0].ypos] = 4;
}

void keyReleased(){
  Human[0].select_vel = 0;
 if(key == CODED){
   if(keyCode == UP){
     MAP[Human[0].xpos][Human[0].ypos-1] = 0;
   }
   else if(keyCode == DOWN){
     MAP[Human[0].xpos][Human[0].ypos+1] = 0;
   }
  else if(keyCode == RIGHT){
     MAP[Human[0].xpos+1][Human[0].ypos] = 0;
  }
 else if(keyCode == LEFT){
    MAP[Human[0].xpos-1][Human[0].ypos] = 0;
 } 
 }
 MAP[Human[0].xpos][Human[0].ypos] = 4;
}
