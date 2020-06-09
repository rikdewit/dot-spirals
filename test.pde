float posx;
float posy;
int size = 15;
float radius = 10;
int levels = 80;

Dot[] dots = new Dot[levels];

void setup(){
    size(1000, 1000);
    frameRate(60);

    for(int i = 0; i < levels; i++){
        dots[i] = new Dot();
    }


}

void draw(){
    background(0);
    translate(width/2, height/2);
    println(frameRate);
    float frames = frameCount/3.0;

    radius = 10;

    for (int i = 1; i < levels+1; i++){
        radius = radius+((width/2)/levels);

        int offset = ((((int(frames)*i)/1)^2)/200);
        posx = cos(offset)*radius;
        posy = sin(offset)*radius;

        float red = map(i,0,levels,0,255);
        float green = ((sin(frames/60.0)+1)/2)*255;
        float blue = ((sin(frames/200.0)+1)/2)*255;


        //draw trailing dots first
        dots[i-1].draw(red, green, blue);
        dots[i-1].update(posx, posy);


        //draw colored dot
        fill(red, green, blue);
        noStroke();
        circle(posx, posy, size);
        
    }

    saveFrame("animation_sequence/dot_###.png");
}



class Dot{
    public float x;
    public float y;
    float[] xHistory = new float[10];
    float[] yHistory = new float[10];

    void update(float x, float y){
        this.x = x;
        this.y = y;
        //shifting array


        for(int i = 0; i < xHistory.length-1; i++){

            xHistory[i] = xHistory[i+1];
            yHistory[i] = yHistory[i+1];
            // println(xHistory[i+1]);
        }
        //appending last position
        xHistory[xHistory.length-1] = x;
        yHistory[yHistory.length-1] = y;
    }

    void draw(float red, float green, float blue){
        for(int i = 0; i < xHistory.length; i++){

            // if(i % 5 == 0){
            
                float prevx = xHistory[i];
                float prevy = yHistory[i];
                fill(red, green, blue, map(i, 0, xHistory.length-1, 50, 80));

                circle(prevx, prevy, map(i, 0, xHistory.length-1, 2, size));
            // }    
        }
    }

}

