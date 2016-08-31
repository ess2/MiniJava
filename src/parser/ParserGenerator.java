package parser;

import java.io.File;
import java.nio.file.Path;

import analisador.lexico.LexerGenerator;

public class ParserGenerator {
	
	public static void main(String[] args) {
		LexerGenerator.main(null);
		File specification = new File("src/parser/SyntaxSpecification.cup");
		generateParser(specification, specification.getParentFile(), "Parser", "Symbols", 1000);
	}
	
	public static void generateParser(File spec, File dest, String parserClassName, String symbolClassName, int conflicts) {

        try {
            // Setando atributos
            java_cup.Main.main(new String[]{"-parser", parserClassName, "-interface", "-symbols", symbolClassName,
                    "-destdir", dest.getAbsolutePath().toString(), "-expect", Integer.toString(conflicts),
                    spec.getAbsolutePath().toString()});

        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}

