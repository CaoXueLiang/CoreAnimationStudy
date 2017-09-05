// This class is a game object controller of sorts.
// It basically ties the physics and graphics objects together, and gives you a
// place to put your controlling logic.

#import "FallingButton.h"

#define SIZE 100.0f

@implementation FallingButton

@synthesize button;
@synthesize touchedShapes;

// This property fulfills the ChipmunkObject protocol.
// It is perhaps the most important thing this class does.
// By maintaining this list of objects, a ChipmunkSpace can easily add and remove complicated game objects.
// Using the C API, you would have to keep references to each Chipmunk object and add them one by one
// based on their type to the Chipmunk space.
@synthesize chipmunkObjects;

static cpFloat frand_unit(){return 2.0f*((cpFloat)rand()/(cpFloat)RAND_MAX) - 1.0f;}

- (void)buttonClicked {
	// Apply a random velcity change to the body when the button is clicked.
	cpVect v = cpvmult(cpv(frand_unit(), frand_unit()), 300.0f);
	body.velocity = cpvadd(body.velocity, v);
	
	//body.angularVelocity += 5.0f*frand_unit();
}

- (void)updatePosition {
	// ChipmunkBodies have a handy affineTransform property that makes working with Cocoa or Cocos2D a snap.
	// This is all you have to do to move a button along with the physics!
	button.transform = body.transform;
}

/*
 1. cpSpace - 这是所有的物理结构体的容器。它有一个大小和一个可选的重力矢量
 2. cpBody - 它是一个固态无弹力的刚体。它有一个坐标，以及其他物理属性，例如质量，运动和摩擦系数等等。
 3. cpShape - 它是一个抽象的几何形状，用来检测碰撞。可以给结构体添加一个多边形，而且cpShape有各种子类来代表不同形状的类型。
 */
- (id)init{
	if(self = [super init]){
		button = [UIButton buttonWithType:UIButtonTypeCustom];
		[button setTitle:@"Click Me!" forState:UIControlStateNormal];
		[button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
		[button setBackgroundImage:[UIImage imageNamed:@"木箱"] forState:UIControlStateNormal];
		button.bounds = CGRectMake(0, 0, SIZE, SIZE);
		[button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchDown];
		
		//创建刚体
		cpFloat mass = 100.0f;
		cpFloat moment = cpMomentForBox(mass, SIZE, SIZE);
		body = [[ChipmunkBody alloc] initWithMass:mass andMoment:moment];
		body.position = cpv(150.0f, 150.0f);
		
		//创建图形
        ChipmunkShape *shape = [ChipmunkPolyShape boxWithBody:body width:SIZE height:SIZE radius: 0.0f];
		//设置弹性和摩擦力
		shape.elasticity = 0.3f;
		shape.friction = 0.3f;
		
        //设置碰撞类型为唯一值（用于callbacks）
		shape.collisionType = [FallingButton class];
		
		//设置关联
		shape.userData = self;

		/* 
         Keep in mind that you can attach multiple collision shapes to each rigid body, and that each shape can have
		 unique properties. You can make the player's head have a different collision type for instance. This is useful
         for brain damage.
		
		 Now we just need to initialize the instance variable for the chipmunkObjects property.
		 ChipmunkObjectFlatten() is an easy way to build this set. You can pass any object to it that
		 implements the ChipmunkObject protocol and not just primitive types like bodies and shapes.
		
		 Notice that we didn't even have to keep a reference to 'shape'. It was created using the autorelease convenience function.
		 This means that the chipmunkObjects NSSet will manage the memory for us. No need to worry about forgetting to call
		 release later when you're using Objective-Chipmunk!*/
		
		// Note the nil terminator at the end! (this is how it knows you are done listing objects)
		chipmunkObjects = [[NSArray alloc] initWithObjects:body, shape, nil];
	}
	return self;
}


@end
