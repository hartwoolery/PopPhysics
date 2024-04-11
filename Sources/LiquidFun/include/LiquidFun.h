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
+ (void)createParticleBoxForSystem:(void *)particleSystem position:(simd_float2)position size:(simd_float2)size;
// add these after @interface and before @end
+ (int)particleCountForSystem:(void *)particleSystem;
+ (void *)particlePositionsForSystem:(void *)particleSystem;
+ (void)worldStep:(CFTimeInterval)timeStep velocityIterations:(int)velocityIterations positionIterations:(int)positionIterations;
+ (void)setParticleLimitForSystem:(void *)particleSystem maxParticles:(int)maxParticles;
+ (void)destroyWorld;
@end

