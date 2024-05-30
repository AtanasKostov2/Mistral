import java.util.ArrayList;

void setup() {
    size(1600, 900);
}

void draw() {
    //delay(100);
}
void mouseClicked() {
    background(0);

    for (int i = 0; i< random(5, 5); i++) {
        DNA d = new DNA();
        d.r();
        for (int j = 0; j<random(10, 10); j++) {
            pushMatrix();
            d.randomize();
            float s = random(35);
            d.max_alpha = d.max_alpha*random(1);
            d.draw_shape(s, random(0.3));
            popMatrix();
        }
    }
}




class DNA {
    float w = -0.2;
    float divergence = 0.04;
    float x_offset = 1.5;
    float step = 0.1;
    float p_m = random(0.9, 2); // period_muli
    float end_x = random(500);
    float drift_const = 5;
    float max_alpha = 255;
    public float rot = 360;

    public void randomize() {
        this.w = random(-0.3, -0.1);
        this.divergence = random(0.04, 0.1);
        this.x_offset = random(0.5, 2);
        this.step = random(0.2, 0.4);
        this.p_m = random(0.5, 2);
        this.end_x = random(1500);
        this.drift_const = random(20);
        this.max_alpha = random(150, 210);
    }

    public float origin_x=0, origin_y=0;
    public void r() {
        this.origin_x=0;
        this.origin_y=0;
        set_xy();
    }

    void draw_shape(float scale, float st_weight) {
        set_xy();

        pushMatrix();

        translate(origin_x, origin_y);
        rotate(radians(random(this.rot)));
        scale(scale);
        strokeWeight(st_weight);

        ArrayList<Float> xs = new ArrayList<>();
        ArrayList<Float> ys = new ArrayList<>();

        float y = 0;
        color c = color(random(255), random(255), random(255));
        fill(c, random(200, this.max_alpha));
        stroke(c, random(40));
        beginShape();
        float old_cone_x = 0;

        for (float x = 0; x< end_x; x+=step) {
            step+=step*0.01; //max increase by 50% of curr
            y = f1(x) + random(this.drift_const)*(x/end_x);

            vertex(x, y);

            pushMatrix();
            scale(0.5);
            if (random(1)>random(0.6, 0.8)) {
                rect(x, y, this.w, -x*this.divergence);
                if (random(1)>0.3) {
                    scale(0.7);
                    circle(x+this.w/2, y-x*this.divergence, 1);
                }
            }
            popMatrix();
            xs.add(x);
            ys.add(y+this.w);
        }
        old_cone_x = xs.get(xs.size()-1);
        for (int i = xs.size()-1; i >0; i--) {
            vertex(xs.get(i), ys.get(i));
        }
        endShape(CLOSE);
        xs.clear();
        ys.clear();
        c = color(random(255), random(255), random(255));
        fill(c, random(40, this.max_alpha));
        stroke(c, random(40));
        beginShape();
        for (float x = 0; x< end_x; x+=step) {
            step+=step*0.01; //max increase by 50% of curr

            y = f2(x) + random(this.drift_const)*(x/end_x);
            vertex(x, y);
            pushMatrix();
            scale(0.5);
            if (random(1)>random(0.6, 0.8)) {
                rect(x, y, this.w, -x*this.divergence);
                if (random(1)>0.3) {
                    scale(0.7);
                    circle(x+this.w/2, y-x*this.divergence, 1);
                }
            }
            popMatrix();
            xs.add(x);
            ys.add(y+this.w);
        }
        for (int i = xs.size()-1; i >0; i--) {
            vertex(xs.get(i), ys.get(i));
        }
        endShape(CLOSE);
        popMatrix();
    }
    float drift(float x) {
        return x*random(0.95, 1.05);
    }
    float f1(float x) {
        return cos(x*this.p_m) + abs(x*divergence);
    }

    float f2(float x) {
        return sin(x*this.p_m + PI*x_offset) - abs(x*divergence);
    }

    void set_xy() {
        if (this.origin_x == 0) {
            this.origin_x = random(width);
        }
        if (this.origin_y ==0) {
            this.origin_y = random(height);
        }
    }
}




void keyReleased() {
    if (key == '2') {
        print("Saving frame", "\n");
        saveFrame("line-#######.png");
    }
}
