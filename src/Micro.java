import java.io.*;
import java.util.*;
import org.antlr.v4.runtime.*;

public class Micro {

	public static class AwesomeErrorStrategy extends DefaultErrorStrategy {
		public void	recover(Parser p, RecognitionException e) {return;};
		public Token recoverInline(Parser recognizer)
				throws RecognitionException
		{
			System.out.println("Not Accepted");
			System.exit(0);
			return(new CommonToken(0));
		}
		public void	reportError(Parser p, RecognitionException e) {	
			System.out.println("Not Accepted");
			System.exit(0);
		}
	}

	public static void main(String[] args) throws Exception {
			CharStream test = new ANTLRFileStream( args[0] );
			MicrolexerLexer lexer = new MicrolexerLexer(test);
			AwesomeErrorStrategy XErrorHandler = new AwesomeErrorStrategy();
			CommonTokenStream tokens = new CommonTokenStream(lexer);
			MicrolexerParser parser = new MicrolexerParser(tokens);
			parser.setErrorHandler(XErrorHandler);					
			parser.setBuildParseTree(true);
			RuleContext tree = parser.program();
//			tree.inspect(parser);
//			System.out.println(tree.toStringTree(parser));	
			System.out.println("Accepted");
	}
}
