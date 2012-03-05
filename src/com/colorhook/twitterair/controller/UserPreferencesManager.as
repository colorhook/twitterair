/*
 * Copyright (c) 2010 the original author or authors
 * 
 * Permission is hereby granted to use, modify, and distribute this file 
 * in accordance with the terms of the license agreement accompanying it.
 */
package com.colorhook.twitterair.controller {

    import com.colorhook.twitterair.vo.UserPreferences;
    
    import flash.filesystem.File;
    import flash.filesystem.FileMode;
    import flash.filesystem.FileStream;
    
    import mx.utils.Base64Decoder;
    import mx.utils.Base64Encoder;
    
    /**
     * UserPreferencesManager is a static class to serialize and deserialize user preferences.
     * @example
     * <pre>
     * var userPref:UserPreferences=UserPreferencesManager.gloadUserPreferences();
     * </pre>
     * @see UserPreferences
     */ 
    public class UserPreferencesManager{
    	
        public static const USER_PREFERENCES_FILE_PATH:String = "UserPreferences.config";
        
        public function UserPreferencesManager() {
          	throw new Error("UserPreferencesUtil is a static class");
        }
        
        /**
         * Serialize the User Preferences to a file.
         */
        public static function saveUserPreferences(userPreferences:UserPreferences):void{
            var file:File = new File(File.applicationDirectory.resolvePath(USER_PREFERENCES_FILE_PATH).nativePath);
            var fileStream:FileStream = new FileStream();
            try{
                fileStream.open(file, FileMode.WRITE);
                fileStream.writeUTFBytes(encode(formatUserPreferencesToString(userPreferences)));
            }catch (error:Error) {
            }finally {
                fileStream.close();
            }
        }
        /**
         * Deserialize the User Preferences from a file.
         */
        public static function loadUserPreferences():UserPreferences{
            var userPreferences:UserPreferences;
            var file:File = new File(File.applicationDirectory.resolvePath(USER_PREFERENCES_FILE_PATH).nativePath);
            var fileStream:FileStream = new FileStream();
            try{
                fileStream.open(file, FileMode.READ);
                var fileContent:String = fileStream.readUTFBytes(fileStream.bytesAvailable);
                userPreferences = createUserPreferencesWithXML(new XML(decode(fileContent)));
              
            }catch (error:Error) {
            }finally {
                fileStream.close();
                return userPreferences;
            }
        }
        
        private static function xmlEntities(value:String):String {
            if (value.indexOf("<") > -1 || value.indexOf(">") > -1 || value.indexOf("'") > -1 || value.indexOf('"') > -1) {
                value = "<![CDATA[" + value + "]]>";
            }
            return value;
        }
        
        private static function formatUserPreferencesToString(userPreferences:UserPreferences):String {
            var data:XML = <user-preferences>
                                <username>{xmlEntities(userPreferences.username)}</username>
                                <password>{xmlEntities(userPreferences.password)}</password>
                                <autoLogin>{Boolean(userPreferences.autoLogin)}</autoLogin>
                                <useProxy>{Boolean(userPreferences.useProxy)}</useProxy>
                                <updateDuration>{String(userPreferences.updateDuration)}</updateDuration>
                                <defaultTwitterAPIProxy>{xmlEntities(userPreferences.defaultTwitterAPIProxy)}</defaultTwitterAPIProxy>
                                <twitterAPIProxy>{xmlEntities(userPreferences.twitterAPIProxy)}</twitterAPIProxy>
                                <AIRUpdateAddress>{xmlEntities(userPreferences.AIRUpdateAddress)}</AIRUpdateAddress>
                                <renrenID>{xmlEntities(userPreferences.renrenID)}</renrenID>
                                <renrenPassword>{xmlEntities(userPreferences.renrenPassword)}</renrenPassword>
                        	</user-preferences>
            return data.toXMLString();
        }
        
        private static function createUserPreferencesWithXML(xml:XML):UserPreferences{
            var userPreferences:UserPreferences = new UserPreferences;
            userPreferences.username=xml.username.toString();
			userPreferences.password=xml.password.toString();
			userPreferences.autoLogin=xml.autoLogin.toString()=="true"
			userPreferences.useProxy=xml.useProxy.toString()=="true";
			userPreferences.defaultTwitterAPIProxy=xml.defaultTwitterAPIProxy.toString();
			userPreferences.twitterAPIProxy=xml.twitterAPIProxy.toString();
			userPreferences.updateDuration=Number(xml.updateDuration.toString());
			userPreferences.AIRUpdateAddress=xml.AIRUpdateAddress.toString();
			userPreferences.renrenID=xml.renrenID.toString();
			userPreferences.renrenPassword=xml.renrenPassword.toString();
            return userPreferences;
        }
        
        public static function encode(value:String):String{
            var encoder:Base64Encoder=new Base64Encoder();
            encoder.encode(value);
            return encoder.toString();
        }

        public static function decode(value:String):String {
            var decoder:Base64Decoder=new Base64Decoder();
            decoder.decode(value);
            return decoder.toByteArray().toString();
        }

    }

}
