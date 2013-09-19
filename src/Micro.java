import java.io.*;
import java.util.*;
import org.antlr.v4.runtime.*;

public class Micro {

	public static void main(String[] args) throws Exception {
			CharStream test = new ANTLRFileStream( args[0] );
			Microlexer lexer = new Microlexer(test);
			Token token;
	
			while(true){

				token = lexer.nextToken();
				if (token.getType() == -1){
					break;
				} else if (token.getType() == 1){
					System.out.printf("Token Type: KEYWORD\nValue: %s\n", token.getText());
				} else if (token.getType() == 2){
					System.out.printf("Token Type: IDENTIFIER\nValue: %s\n", token.getText());
				} else if (token.getType() == 3){
					System.out.printf("Token Type: FLOATLITERAL\nValue: %s\n", token.getText());
				} else if (token.getType() == 4){
					System.out.printf("Token Type: INTLITERAL\nValue: %s\n", token.getText());
				} else if (token.getType() == 5){
					System.out.printf("Token Type: STRINGLITERAL\nValue: %s\n", token.getText());
				} else if (token.getType() == 6){
					System.out.printf("Token Type: OPERATOR\nValue: %s\n", token.getText());
				}
			}
	}
}
