//
//  LiquidFun.mm
//
//
//  Created by Hart Woolery on 4/10/24.
//


#import "LiquidFun.h"
#include <Box2D.h>


static b2World *world;
//static b2ParticleGroup *group;

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
    particleSystemDef.viscousStrength = 1.0;
    particleSystemDef.pressureStrength = 1.0;
    
    b2ParticleGroupDef groupDef;
    //groupDef.groupFlags = b2_solidParticleGroup;
    
    b2ParticleSystem *particleSystem = world->CreateParticleSystem(&particleSystemDef);
    //group = particleSystem->CreateParticleGroup(groupDef);
    
    return particleSystem;
}

+ (void)createParticleForSystem:(void *)particleSystem position:(simd_float2)position velocity:(simd_float2)velocity size:(float)size lifetime:(float)lifetime {
    
    //b2PolygonShape shape;
    //shape.SetAsBox(size*0.5f,size*0.5f);// * 0.5f, size * 0.5f);
    
    b2ParticleDef particleDef;
    particleDef.flags = b2_viscousParticle;
    particleDef.position.Set(position.x, position.y);
    particleDef.velocity.Set(velocity.x, velocity.y);
    particleDef.lifetime = lifetime;
    //particleDef.group = group;
  
    //particleGroupDef.shape = &shape;
    
    ((b2ParticleSystem *)particleSystem)->SetRadius(size*0.5);
    ((b2ParticleSystem *)particleSystem)->CreateParticle(particleDef);
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
//    shape.Set(b2Vec2(0, size.y), b2Vec2(size.x, size.y));
//    body->CreateFixture(&shape, 0);
    
    // left
    shape.Set(b2Vec2(0, size.y), b2Vec2(0, 0));
    body->CreateFixture(&shape, 0);
    
    // right
    shape.Set(b2Vec2(size.x, size.y), b2Vec2(size.x, 0));
    body->CreateFixture(&shape, 0);
    
    return body;
}

+ (void *)createPhysicsBody:(int)type {
    b2BodyDef bodyDef;
    bodyDef.type = b2_kinematicBody;
    b2Body *body = world->CreateBody(&bodyDef);
    
    if (type == 0) {
        b2CircleShape shape;
        body->CreateFixture(&shape, 0);
    } else if (type == 1)
    {
        b2EdgeShape shape;
        body->CreateFixture(&shape, 0);
        
    }
    
    return body;
}
+ (void)setPhysicsBodyCenter:(void *)body center:(simd_float2)center  {
    ((b2Body *)body)->SetTransform(b2Vec2(center.x, center.y), 0.0f);
}

+ (void)setPhysicsBodySize:(void *)body size:(float)radius {
    b2Shape* shape = ((b2Body *)body)->GetFixtureList()->GetShape();
    shape->m_radius = radius;
}

+ (void)setPhysicsBodyEdge:(void *)body p1:(simd_float2)p1 p2:(simd_float2)p2  {
    b2EdgeShape* shape = (b2EdgeShape *)((b2Body *)body)->GetFixtureList()->GetShape();
    shape->Set(b2Vec2(p1.x, p1.y), b2Vec2(p2.x, p2.y));
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

