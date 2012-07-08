
String originalPath;
String basename;
float gw;
float gh;
color acol;
PImage img;

ArrayList elements;

void setup() {
  colorMode(HSB,255);
  
  acol = color(0,0,0);
  originalPath = "girl_profile.jpg";
  basename = splitTokens(originalPath,".")[0];
  
  img = loadImage("http://localhost:3000/uploads/texture/rhymeandreason/43/image/nyc-square.jpg");
  img.loadPixels();
  gw = img.width;
  gh = img.height;
  
  size(500,500);
  elements = new ArrayList();
  makePixelated(img,40,false,0);
  
}

void keyPressed() {
  if (key == 'q') {
   makePixelated(img,40,false,0);
  } else if (key == 'w') {
   makePixelated(img,40,true,0);
  } else if (key == 'e') { 
    makePixelated(img,40,false,1);
  } else if (key == 'r') {
    makePixelated(img,40,true,1);
  } else if (key == 't') {
    makeHalftone(img,40,false,0);
  } else if (key == 'y') {
    makeHalftone(img,40,true,0);
  } else if (key == 'u') {
    makeHalftone(img,40,false,1);
  } else if (key == 'i') {
    makeHalftone(img,40,true,1);
  } else if (key == 'a') {
    makeSketch(img, 130, 180, 1.0);
  }
}

void draw() {
  //fill(acol);
  //rect(0,0,width, height);
  for (int i=0; i<elements.size(); i++) {
   Element el = (Element)elements.get(i);
   el.draw(); 
  }
  
}

void makePixelated(PImage img, int xres, boolean grey, int type) {
  elements.clear();
  
  int w = img.width;
  int h = img.height;
  float aspect = (1.0*w)/(1.0*h);
  int yres = int(xres/aspect);
  color[][] ps = make2D(img.pixels, w, h);
  
  acol = getMedian(ps,w,h,grey);
  
  int bw = int(w/(1.0*xres));
  int bh = int(h/(1.0*yres));
  
  size(bw*xres,bh*yres);
  
  for (int i = 0;i<xres;i++) {
   for (int j = 0; j<yres; j++) {
     int atx = i*bw;
     int aty = j*bh;
     int rbw = min(bw,w-atx);
     int rbh = min(bh,h-aty);
     
    color[][] bucket = new color[rbw][rbh];
    for (int x = 0; x<rbw; x++) {
      for (int y = 0; y<rbh; y++) {
       bucket[x][y] = ps[x+atx][y+aty]; 
      }
    }
    
    color bcol = getMedian(bucket,rbw,rbh,grey);
    int cx = atx+rbw/2;
    int cy = aty+rbh/2;
    Element el = new Element(type,cx,cy,rbw,rbh,bcol); 
    elements.add(el);
   } 
  }
  
}

void makeHalftone(PImage img, int xres, boolean grey, int type) {
  elements.clear();
  
  int w = img.width;
  int h = img.height;
  float aspect = (1.0*w)/(1.0*h);
  int yres = int(xres/aspect);
  color[][] ps = make2D(img.pixels, w, h);
  
  acol = color(255,0,255);
  
  int bw = int(w/(1.0*xres));
  int bh = int(h/(1.0*yres));
  
  size(bw*xres,bh*yres);
  
  for (int i = 0;i<xres;i++) {
   for (int j = 0; j<yres; j++) {
     int atx = i*bw;
     int aty = j*bh;
     int rbw = min(bw,w-atx);
     int rbh = min(bh,h-aty);
     
    color[][] bucket = new color[rbw][rbh];
    for (int x = 0; x<rbw; x++) {
      for (int y = 0; y<rbh; y++) {
       bucket[x][y] = ps[x+atx][y+aty]; 
      }
    }
    
    color bcol = getMedian(bucket,rbw,rbh,grey);
    int cx = atx+rbw/2;
    int cy = aty+rbh/2;
    
    float sz = max(rbw,rbh)*(255.0-brightness(bcol))/255.0;
    if (grey)
     bcol = color(0,0,0);
    else {
     bcol = color(hue(bcol),255,255);  
    }
    
    Element el = new Element(type,cx,cy,sz,sz,bcol); 
    elements.add(el);
   } 
  }
}

void makeSketch(PImage img, double ang, int threshold, float strk) {
  
}

String makeName(String type) {
 String[] namepts = new String[4];
  namepts[0] = basename;
  namepts[1] = "_";
  namepts[2] = type;
  namepts[3] = "svg"; 
  
  String name = join(namepts,"");
  
  return name;
}

color[][] make2D(color[] ps, int w, int h) {
 color[][] mat = new color[w][h];
 for (int i=0; i<w; i++) {
  for (int j=0; j<h; j++) {
    
   mat[i][j] = ps[j*w+i]; 
  }
 } 
 
 return mat;
}

color getMedian(color[][] bucket, int w, int d, boolean bw) {
  color m;
  float[] h = new float[w*d];
  float[] s = new float[w*d];
  float[] b = new float[w*d];
  
   for (int j=0; j<d; j++) {
  for (int i=0; i<w; i++) {
    h[w*j+i] = hue(bucket[i][j]);
    s[w*j+i] = saturation(bucket[i][j]);
    b[w*j+i] = brightness(bucket[i][j]);
   } 
  }
 
  
  h = sort(h);
  s = sort(s);
  b = sort(b);
  
  int mid = w*d/2;
  
  float rs = s[mid];
  
  if (bw) rs = 0;
  
  colorMode(HSB,255);
  m = color(h[mid],rs,b[mid]);
  
  return m;
}

color getAverage( color[][] bucket, int w, int d, boolean bw) {
  color m;
  float[] h = new float[w*d];
  float[] s = new float[w*d];
  float[] b = new float[w*d];
  
  for (int i=0; i<w; i++) {
   for (int j=0; j<d; j++) {
    h[w*j+i] = hue(bucket[i][j]);
    s[w*j+i] = saturation(bucket[i][j]);
    b[w*j+i] = brightness(bucket[i][j]);
   } 
  }
  
  float ah = 0;
  float as = 0;
  float ab = 0;
  
  for (int i=0;i<w*d; i++) {
    ah += h[i];
    as += s[i];
    ab += b[i];
  }
  
  ah = ah/(w*d*1.0);
  as = as/(w*d*1.0);
  ab = ab/(w*d*1.0);
  
  float rs = as;
  
  if (bw) rs = 0;
  
  colorMode(HSB,255);
  m = color(ah,rs,ab);
  
  return m;
}

void writeSVG(ArrayList els, String name) {
String[] svg = {"<?xml version=\"1.0\" encoding=\"utf-8\"?>",
"<!-- Generator: svg_filters by continuum fashion svg exporter code  -->",
"<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.1//EN\" \"http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd\">",
"<svg version=\"1.1\" id=\"Layer_1\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\" x=\"0px\" y=\"0px\""};

String arealn ="    width=\""+ str(width) +"px\" height=\"" + str(height) + "px\" viewBox=\"0 0 " + str(width) + " " + str(height) + "\" enable-background=\"new 0 0 " +str(width)+" "+str(height)+"\" xml:space=\"preserve\">";
svg = append(svg,arealn);

for (int i=0; i<elements.size(); i++) {
   Element el = (Element)els.get(i);
   
   String ln = " ";
   if (el.type == 0) {
     ln = "<rect x=\"" + str(el.cx-el.w*0.5) + "\" y=\"" + str(el.cy-el.h*0.5) + "\" fill=\"#" +str(el.col)+ "\" width=\"" + str(el.w) + "\" height=\"" + str(el.h) + "\"/>";
   } else if (el.type == 1) {
     ln = "<circle cx=\""+str(el.cx)+"\" cy=\""+str(el.cy)+"\" fill=\"#" +str(el.col)+ "\" r=\""+str(el.w*0.5)+"\"/>";
   } else if (el.type == 1) {
     ln = "<line fill=\"none\" stroke=\"#"+str(el.col)+"\" stroke-miterlimit=\"10\" x1=\""+str(el.cx)+"\" y1=\""+str(el.cy)+"\" x2=\""+str(el.w)+"\" y2=\""+str(el.h)+"\"/>";
   }
   
   svg = append(svg,ln);
   
   
}


String endln = "</svg>";
svg = append(svg,endln);

}

class Element {
  int type; // 0 rect, 1 circle, 2 line
  float cx;
  float cy;
  float w;
  float h;
  color col;
 Element(int itype, float icx, float icy, float iw, float ih, color icol) {
  type = itype;
  cx = icx;
  cy = icy;
  w = iw;
  h = ih;
  col = icol;
 } 
 void draw() {
   if (type == 0 || type == 1) {
    noStroke();
    fill(col); 
   }
   
   if (type == 3) {
    noFill();
   stroke(col); 
   }
   
   if (type == 0) {
    rectMode(CENTER);
    rect(cx,cy,w,h); 
   }
   
   if (type == 1) {
     ellipseMode(CENTER);
     ellipse(cx,cy,w,h); 
   }
   
   if (type == 2) {
    line(cx,cy,w,h); 
   }
 }
}