
package analisador.lexico;

import java.io.File;
import java.nio.file.Path;

import jflex.SilentExit;

public class LexerGenerator {
	
	public static void main(String[] args) {
		File specification = new File("src/analisador/lexico/LexerSpecification.flex");
		generateLexer(specification, specification.getParentFile());
	}
	
	public static void generateLexer(File spec, File dest) {
	        try {
	        	
	            jflex.Main.parseOptions(new String[]{"-d", dest.getAbsolutePath().toString()}); //Altera apontador
	            
	            jflex.Main.generate(new String[]{spec.getAbsolutePath().toString()}); //Gera o arquivo

	        } catch (SilentExit silentExit) {
	            silentExit.printStackTrace();
	        }
	    }
	 
	 
}
