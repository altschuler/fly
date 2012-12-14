﻿package com.actionsnippet.qbox.objects{		import flash.display.*	import flash.events.*;		import com.actionsnippet.qbox.*	import com.actionsnippet.geom.*; 	import Box2D.Dynamics.*;	import Box2D.Collision.*;	import Box2D.Collision.Shapes.*;	import Box2D.Common.Math.*;	import Box2D.Dynamics.Joints.*;		/**	PolyObject is a subclass of {@link com.actionsnippet.qbox.QuickObject} and should only be instantiated with the {@link com.actionsnippet.qbox.QuickBox2D#addPoly()} method.		@author Zevan Rosser	@version 1.1	*/		public class PolyObject extends QuickObject {				public static var tri:Triangulate = new Triangulate();				   		public function PolyObject(qbox:QuickBox2D, params:Object){			super(qbox, params);		}				override protected function defaultParams(p:Object):void{			p.verts = [[-.5, -1, 1, -1, 1, 1, -1, 1]];			p.wireframe = true;		}				override protected function build():void{			 			var p:Object = params;						var i:int;			var inc:int;			var leng:int;			// see if a points array has been passed in, if so			// triangulate the points and populate the verts array accordingly			if (p.points){				var poly:Array = p.points;				var pnts:Array = [];								inc = 0;				leng = poly.length - 2;				for (i = 0; i<leng; i+=2){					pnts[inc] = new Pnt(poly[i], poly[i + 1]);					inc++;				}								poly = PolyObject.tri.process(pnts);								inc = 0;				p.verts = [];				leng = poly.length;				for (i = 0; i<leng; i+=3) {							var p1:Pnt=poly[i];							var p2:Pnt=poly[i+1];							var p3:Pnt=poly[i+2];							p.verts[inc] = [p1.x, p1.y, p2.x, p2.y, p3.x, p3.y];							inc++;				}				pnts = p.points;			}			 						var autoSkin:Boolean = false;			if (p.skin is Class){					bodyDef.userData = new p.skin();			}else		    if (p.skin is DisplayObject){				bodyDef.userData = p.skin;			}else if(p.skin != "none"){					bodyDef.userData = new Sprite();					autoSkin = true;					 					 if (p.points){						with(bodyDef.userData.graphics){								lineStyle(p.lineThickness,p.lineColor, p.lineAlpha);								beginFill(p.fillColor, p.fillAlpha);								 								moveTo(pnts[0] * 30, pnts[1] * 30);								for (i = 2; i<pnts.length - 2; i+=2){									lineTo(pnts[i] * 30, pnts[i + 1] * 30);								}								endFill();						}					 }			}			body = w.CreateBody(bodyDef);			shapeDef = [];			for (var j:int = 0; j<p.verts.length; j++){				var polyDef:b2PolygonDef = new b2PolygonDef();				shapeDef.push(polyDef);				polyDef.vertexCount = int(p.verts[j].length / 2);								if (p.verts[j][i] is b2Vec2){						polyDef.vertices = p.verts[j];				}else{					inc = 0;					for (i= 0; i<p.verts[j].length; i+=2){						polyDef.vertices[inc].Set(p.verts[j][i], p.verts[j][i + 1]);						inc++;					}				}								polyDef.density = p.density;				polyDef.friction = p.friction;				polyDef.restitution = p.restitution;				polyDef.filter.maskBits = p.maskBits;			    polyDef.filter.categoryBits = p.categoryBits;			    polyDef.filter.groupIndex = p.groupIndex;								 if (autoSkin && p.wireframe){					with(bodyDef.userData.graphics){							lineStyle(p.lineThickness,p.lineColor, p.lineAlpha);					        beginFill(p.fillColor, p.fillAlpha);					}					for (i  =0; i<polyDef.vertexCount; i++){						with(bodyDef.userData.graphics){							if (i == 0){								moveTo(polyDef.vertices[i].x * 30, polyDef.vertices[i].y * 30);							}else{								lineTo(polyDef.vertices[i].x * 30, polyDef.vertices[i].y * 30);							}						}					}					bodyDef.userData.graphics.endFill();				}								shape = body.CreateShape(polyDef);			}		}	}}