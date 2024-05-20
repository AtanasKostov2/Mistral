boolean mouse_test = false;
Star s;
void setup() {
    size(1920, 1080);
    background(0);
    mouseClicked();
}
void draw() {
}
void random() {
    background(0);
    Galaxy c5 = new Galaxy(random(1, 20), random(20, 80), false, false, true);

    Eye e = new Eye();
    e.step/=2;
    e.draw_shape();

    Galaxy g1 = new Galaxy(0.03, random(4000, 5400), true, false, false);
    if (random(1)>0.5) {
        Eye e2 = new Eye();
        e2.step/=2;
        e2.draw_shape();
        print("Second eye\n");
    }
    Galaxy g2 = new Galaxy(0.04, random(250, 450), true, false, false);
    Galaxy g3 = new Galaxy(0.05, random(250, 400), true, false, false);


    if (random(1)>0.7) {
        Eye e3 = new Eye();
        e3.step/=2;
        e3.draw_shape();
        print("Third eye\n");
    }
    if (random(1) >0.95) {
        for (int i =0; i<5; i++) {
            Eye ex = new Eye();
            ex.step/=2;
            ex.draw_shape();
        }
        print("X5\n");
    }
    Galaxy g4 = new Galaxy(0.07, random(200, 400), true, false, false);
}
void mouseClicked()
{
    random();
    /*
    background(0);
     Galaxy c5 = new Galaxy(5, random(50, 100), false, false, true);
     
     Eye e = new Eye();
     e.step/=2;
     e.draw_shape();
     
     Galaxy g1 = new Galaxy(0.03, random(4000, 5400), true, false, false);
     Eye e2 = new Eye();
     e2.step/=2;
     e2.draw_shape();
     Galaxy g2 = new Galaxy(0.04, random(250, 450), true, false, false);
     Galaxy g3 = new Galaxy(0.05, random(250, 400), true, false, false);
     
     
     Eye e3 = new Eye();
     e2.step/=2;
     e3.draw_shape();
     
     Galaxy g4 = new Galaxy(0.07, random(200, 400), true, false, false);
     */
}

class Eye {
    float x, y, r;
    float log_base;
    color star_color;
    float scale_l=280;
    float scale_h=330;
    float rot = -28;
    float end = 2.1;
    float step= 0.01;


    Eye() {
        this.x = width/2;
        this.y = height/2;
        this.r = -0.3;
        this.log_base = random(9, 100);
    }
    float func_outer(float x_loc) {
        //log(y^2)+x^2=a -> outer shape
        return pow(this.log_base, (this.r-pow(x_loc, 2))/2);
    }
    float func_inner(float x_loc) {
        //log(y)+x^2=a -> inner shape
        return pow(this.log_base, this.r-pow(x_loc, 2));
    }

    float func_circle(float x_loc) {
        if (x_loc>sqrt(0.1)) {
            x_loc = sqrt(0.1);
        }
        return sqrt(0.1-pow(x_loc, 2));
    }


    public void draw_shape() {
        pushMatrix();
        translate(x, y);
        rotate(radians(this.rot));
        scale(random(this.scale_l, this.scale_h));

        create_shape3();
        create_shape();
        Core c = new Core();
        c.x = 0;
        c.y = 0;
        c.core_r = random(10, 62);
        c.core_rim = random(c.core_r*1.5, c.core_r*2);
        pushMatrix();
        scale(0.01);
        c.draw_core();
        popMatrix();
        popMatrix();
    }
    public void create_shape3() {
        int base_col = 100;
        float drift = 0.05;
        //outer eyelid
        beginShape();
        strokeWeight(0.1);

        color outer_col = get_color();
        fill(outer_col, 20);//color(51, 22, 26));
        stroke(outer_col, 40);//color(38, 14, 17), 150);
        for (float i = -this.end; i< this.end; i+=this.step) {
            vertex(i, func_outer(i));
        }
        for (float i = this.end; i> -this.end; i-=this.step) {
            vertex(i, -func_outer(i));
        }
        endShape(CLOSE);

        fill(get_color(), 50);//color(74, 25, 32), 200);
        stroke(get_color(), 40);//color(68, 27, 33), 50);
        beginShape();
        for (float i = -this.end; i<this.end; i+=this.step) {
            vertex(i, func_inner(i));
        }
        for (float i = this.end; i> -this.end; i-=this.step) {
            vertex(i, -func_inner(i));
        }
        endShape(CLOSE);

        fill(get_color(), 70);//color(97, 25, 34), 250);
        strokeWeight(random(0.05, 0.15));
        stroke(get_color(), 20);//color(166, 39, 56), 50);

        beginShape();
        for (float i = -0.31; i< 0.31; i+=0.01) {
            vertex(i, func_circle(i));
        }
        for (float i = 0.31; i> -0.31; i-=0.01) {
            vertex(i, -func_circle(i));
        }
        endShape(CLOSE);
        /*
        pushMatrix();
         scale(0.99);
         beginShape();
         for (float i = -0.31; i< 0.31; i+=0.01) {
         vertex(i, func_circle(i));
         }
         for (float i = 0.31; i> -0.31; i-=0.01) {
         vertex(i, -func_circle(i));
         }
         endShape(CLOSE);
         popMatrix();
         strokeWeight(0.07);
         */
    }
    public void create_shape2() {
        float step= 0.01;
        int base_col = 100;
        for (float i = -end; i< end; i+=step) {
            fill(color(0, 0, base_col));
            stroke(color(0, 0, base_col));
            circle(i, func_outer(i), 0.01);

            fill(color(base_col, 0, base_col));
            stroke(color(base_col, 0, base_col));
            circle(i, func_inner(i), 0.01);

            fill(color(0, 0, base_col));
            stroke(color(0, 0, base_col));
            circle(i, -func_outer(i), 0.01);

            fill(color(base_col, 0, base_col));
            stroke(color(base_col, 0, base_col));
            circle(i, -func_inner(i), 0.01);
        }
        for (float i = -0.31; i< 0.31; i+=0.01) {
            fill(color(base_col, 0, 0));
            stroke(color(base_col, 0, 0));
            circle(i, func_circle(i), 0.1);
            circle(i, -func_circle(i), 0.1);
        }
    }

    public void create_shape() {
        int stroke_alpha = 40;
        int base_col = 100;
        float drift = 0;
        for (float i = -this.end; i< this.end; i+=this.step) {
            fill(color(0, 0, base_col), stroke_alpha);
            stroke(color(0, 0, base_col), stroke_alpha);
            circle(i+get_drift(drift), func_outer(i)+get_drift(drift), 0.01);

            fill(color(base_col, 0, base_col), stroke_alpha);
            stroke(color(base_col, 0, base_col), stroke_alpha);
            circle(i+get_drift(drift), func_inner(i), 0.01);

            fill(color(0, 0, base_col), stroke_alpha);
            stroke(color(0, 0, base_col), stroke_alpha);
            circle(i+get_drift(drift), -func_outer(i)+get_drift(drift), 0.01);

            fill(color(base_col, 0, base_col), stroke_alpha);
            stroke(color(base_col, 0, base_col), stroke_alpha);
            circle(i+get_drift(drift), -func_inner(i) + get_drift(drift), 0.01);
        }
        /*
        for (float i = -0.31; i< 0.31; i+=0.05) {
         fill(color(base_col, 0, 0), stroke_alpha);
         stroke(color(base_col, 0, 0), stroke_alpha);
         circle(i+get_drift(drift), func_circle(i) + get_drift(drift), 0.01);
         circle(i+get_drift(drift), -func_circle(i) + get_drift(drift), 0.01);
         }
         */
    }
    float get_drift(float drift) {
        return random(-drift, drift);
    }
}
class Galaxy {
    int n;
    float scale;
    boolean use_star = true;
    boolean use_core = false;
    boolean use_eye = false;
    Galaxy(float scale, float n, boolean use_star, boolean use_core, boolean use_eye) {
        this.n = (int)n;
        this.scale = scale;
        this.use_star = use_star;
        this.use_core = use_core;
        this.use_eye = use_eye;
        draw_shape();
    }
    void draw_eye() {
        Eye e = new Eye();
        e.scale_l=1;
        e.scale_h=5*this.scale;
        e.x = random(width);
        e.y = random(height);
        e.step = 0.3;
        e.end = 1.6;
        e.rot = random(360);
        e.draw_shape();
    }
    void draw_core() {
        pushMatrix();
        Core c = new Core();
        translate(c.x, c.y);
        c.alpha_scaler = 0.2;
        c.core_rim = c.core_r*random(3, 7);
        scale(this.scale);
        c.draw_core();
        popMatrix();
    }
    void draw_star() {
        pushMatrix();

        Star s = new Star();
        s.r = random(3, 4);
        s.step=3;
        translate(s.x, s.y);
        scale(random(this.scale));
        s.draw_shape();

        popMatrix();
    }
    public void draw_shape() {
        for (int i = 0; i<n; i++) {
            if (this.use_star == true) {
                draw_star();
            }
            if (this.use_core == true) {
                draw_core();
            }
            if (this.use_eye == true) {
                draw_eye();
            }
        }
    }
}
class Star {

    //Core core = new Core();
    float x, y, r;
    int log_base;
    color star_color;
    float rot;
    int end = 700;
    float step= 1;

    Star() {
        this.x = get_x();
        this.y = get_y();
        this.r = 4;
        this.log_base = 30;
        this.star_color= get_color();
        this.rot = random(360);
    }
    float func(float x_loc) {
        //log(x^2)+log(y^2)=a -> star shape
        return pow(this.log_base, this.r/2)/x_loc;
    }

    public void draw_shape() {
        strokeWeight(0);
        stroke(0);
        pushMatrix();
        translate(x, y);

        rotate(radians(this.rot));
        fill(this.star_color);
        create_shape();
        popMatrix();
    }
    public void create_shape() {
        beginShape();
        for (float i = -this.end; i< this.end; i+=this.step) {
            if (i<-0.5) {
                vertex(i, +func(i));
            } else if (i>0.5) {
                vertex(i, -func(i));
            }
        }
        for (float i = this.end; i>-this.end; i-=this.step) {
            if (i<-0.5) {
                vertex(i, -func(i));
            } else if (i>0.5) {
                vertex(i, +func(i));
            }
        }


        endShape(CLOSE);
    }
}
class Core {
    float x, y;
    float core_r, core_rim;
    float core_rim_alpha_l = 40, core_rim_alpha_h=140;
    color core_color;
    float alpha_scaler = 1;

    Core() {
        this.x = get_x();
        this.y = get_y();
        this.core_r = random(10, 150);
        this.core_color = get_color();
        this.core_rim = this.core_r+(this.core_r/150)*this.core_r+random(core_r/5+20);
        //info();
    }

    public void color_core() {
        fill(core_color, 255*this.alpha_scaler);
        stroke(this.core_color, (50+random(50))*this.alpha_scaler);
        strokeWeight(sqrt(this.core_r));
    }

    public void draw_core_rim() {
        // draw outer core rim and inner white contrast
        float a = random(this.core_rim_alpha_l, this.core_rim_alpha_h) - log(this.core_r);
        a = a*this.alpha_scaler*this.alpha_scaler;
        fill(this.core_color, a);
        stroke(this.core_color, a*random(0.5));
        strokeWeight(random(sqrt(this.core_rim)));
        circle(this.x, this.y, this.core_rim);
        fill(255, a*this.alpha_scaler);
        circle(this.x, this.y, this.core_r+log(this.core_r));
    }
    public void draw_core() {
        draw_core_rim();
        color_core();
        circle(this.x, this.y, this.core_r);
    }
    void info() {
        print("(x =", this.x, ", ");
        print("y =", this.y, ")\n");
        print("core_r =", this.core_r, ",", "core_rim=", this.core_rim, "\n");
        print("color =", this.core_color);
        print("\n\n");
    }
}


color get_color() {
    return color(random(255), random(255), random(255));
}
float get_x() {
    if (mouse_test==true) {
        return mouseX;
    } else {
        return random(10, width-10);
    }
}
float get_y() {
    if (mouse_test==true) {
        return mouseY;
    } else {
        return random(10, height-10);
    }
}

void keyReleased() {
    if (key == '1') {
        mouse_test = !mouse_test;
        print("moust_test =", mouse_test, "\n");
    }
    if (key == '2') {
        print("Saving frame", "\n");
        saveFrame("line-#######.png");
    }
}
