//
//  LiquidFun.mm
//
//
//  Created by Hart Woolery on 4/10/24.
//


#import "LiquidFun.h"
#include <Box2D.h>


static b2World *world;

@implementation LiquidFun

// add inside @implementation
+ (void)createWorldWithGravity:(simd_float2)gravity {
  world = new b2World(b2Vec2(gravity.x, gravity.y));
}

+ (void *)createParticleSystemWithRadius:(float)radius dampingStrength:(float)dampingStrength gravityScale:(float)gravityScale density:(float)density {
  b2ParticleSystemDef particleSystemDef;
  particleSystemDef.radius = radius;
  particleSystemDef.dampingStrength = dampingStrength;
  particleSystemDef.gravityScale = gravityScale;
  particleSystemDef.density = density;
  
  b2ParticleSystem *particleSystem = world->CreateParticleSystem(&particleSystemDef);
  
  return particleSystem;
}

+ (void)createParticleBoxForSystem:(void *)particleSystem position:(simd_float2)position size:(simd_float2)size {
  b2PolygonShape shape;
  shape.SetAsBox(size.x * 0.5f, size.y * 0.5f);
  
  b2ParticleGroupDef particleGroupDef;
  particleGroupDef.flags = b2_waterParticle;
  particleGroupDef.position.Set(position.x, position.y);
  particleGroupDef.shape = &shape;
  
  ((b2ParticleSystem *)particleSystem)->CreateParticleGroup(particleGroupDef);
}

+ (void)setParticleLimitForSystem:(void *)particleSystem maxParticles:(int)maxParticles {
  ((b2ParticleSystem *)particleSystem)->SetDestructionByAge(true);
  ((b2ParticleSystem *)particleSystem)->SetMaxParticleCount(maxParticles);
}

+ (void *)createEdgeBoxWithOrigin:(simd_float2)origin size:(simd_float2)size {
  // create the body
  b2BodyDef bodyDef;
  bodyDef.position.Set(origin.x, origin.y);
  b2Body *body = world->CreateBody(&bodyDef);
  
  // create the edges of the box
  b2EdgeShape shape;
  
  // bottom
  shape.Set(b2Vec2(0, 0), b2Vec2(size.x, 0));
  body->CreateFixture(&shape, 0);
  
  // top
  shape.Set(b2Vec2(0, size.y), b2Vec2(size.x, size.y));
  body->CreateFixture(&shape, 0);
  
  // left
  shape.Set(b2Vec2(0, size.y), b2Vec2(0, 0));
  body->CreateFixture(&shape, 0);
  
  // right
  shape.Set(b2Vec2(size.x, size.y), b2Vec2(size.x, 0));
  body->CreateFixture(&shape, 0);
  
  return body;
}

+ (int)particleCountForSystem:(void *)particleSystem {
  return ((b2ParticleSystem *)particleSystem)->GetParticleCount();
}

+ (void *)particlePositionsForSystem:(void *)particleSystem {
  return ((b2ParticleSystem *)particleSystem)->GetPositionBuffer();
}

+ (void)worldStep:(CFTimeInterval)timeStep velocityIterations:(int)velocityIterations positionIterations:(int)positionIterations {
  world->Step(timeStep, velocityIterations, positionIterations);
}

+ (void)setGravity:(simd_float2)gravity {
  world->SetGravity(b2Vec2(gravity.x, gravity.y));
}

+ (void)destroyWorld {
  delete world;
  world = NULL;
}

@end

