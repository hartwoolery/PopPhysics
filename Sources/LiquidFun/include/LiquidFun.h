//
//  Box2DBridge.h
//
//
//  Created by Hart Woolery on 4/10/24.
//

#import <Foundation/Foundation.h>
#import <simd/simd.h>

#ifndef Box2DBridge_h
#define Box2DBridge_h

// LFWrapper.h

/*
typedef struct Vector2D {
  float x;
  float y;
} Vector2D;

typedef struct Size2D {
  float width;
  float height;
} Size2D;*/

#endif /* Box2DBridge_h */

@interface LiquidFun : NSObject

+ (void)setGravity:( simd_float2 )gravity;
+ (void)createWorldWithGravity:(simd_float2)gravity;
+ (void *)createEdgeBoxWithOrigin:(simd_float2 )origin size:(simd_float2)size;
+ (void *)createParticleSystemWithRadius:(float)radius dampingStrength:(float)dampingStrength gravityScale:(float)gravityScale density:(float)density;
+ (void)createParticleForSystem:(void *)particleSystem position:(simd_float2)position velocity:(simd_float2)velocity size:(float)size lifetime:(float)lifetime;

+ (void *)createPhysicsBody:(int)type;
+ (void)setPhysicsBodyCenter:(void *)body center:(simd_float2)center;
+ (void)setPhysicsBodySize:(void *)body size:(float)radius;
+ (void)setPhysicsBodyEdge:(void *)body p1:(simd_float2)p1 p2:(simd_float2)p2;


+ (int)particleCountForSystem:(void *)particleSystem;
+ (void *)particlePositionsForSystem:(void *)particleSystem;
+ (void)worldStep:(CFTimeInterval)timeStep velocityIterations:(int)velocityIterations positionIterations:(int)positionIterations;
+ (void)setParticleLimitForSystem:(void *)particleSystem maxParticles:(int)maxParticles;
+ (void)destroyWorld;
@end

