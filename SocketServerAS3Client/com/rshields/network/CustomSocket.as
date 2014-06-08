﻿package com.rshields.network {	//import flash.display.Sprite;	import flash.errors.*;	import flash.events.*;	import flash.net.Socket;	public class CustomSocket extends Socket {		public var response:Array = new Array();		public var messageSender:IEventDispatcher = new EventDispatcher();		public const NEW_MSG:String = "new message";		public function CustomSocket(host:String = null, port:uint = 0) {			super(host, port);			configureListeners();		}		private function configureListeners():void {			addEventListener(Event.CLOSE, closeHandler);			addEventListener(Event.CONNECT, connectHandler);			addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);			addEventListener(SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler);			addEventListener(ProgressEvent.SOCKET_DATA, socketDataHandler);		}		public function write(str:String):void {			trace("CustomSocket.write(" + str + ")");			try {				writeUTFBytes(str);				flush();			} catch (e:IOError) {				trace(e);			}		}		private function read():void {			var str:String = readUTFBytes(bytesAvailable);			response[response.length] = str;			trace ("CustomSocket.read(" + response[response.length-1] + ")");			messageSender.dispatchEvent(new Event(this.NEW_MSG));		}		private function closeHandler(event:Event):void {			trace("CustomSocket.closeHandler(" + event + ")");			trace(response.toString());		}		private function connectHandler(event:Event):void {			trace("CustomSocket.connectHandler(" + event + ")");		}		private function ioErrorHandler(event:IOErrorEvent):void {			trace("CustomSocket.ioErrorHandler(" + event + ")");		}		private function securityErrorHandler(event:SecurityErrorEvent):void {			trace("CustomSocket.securityErrorHandler(" + event + ")");		}		private function socketDataHandler(event:ProgressEvent):void {			trace("CustomSocket:socketDataHandler: " + event);			read();		}	}}