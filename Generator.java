import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.Locale;

public class Generator {
    public static void main(String[] args) throws IOException {
        String sentence = Files.readString(Paths.get("text_to_generate_terms.txt"));

        String[] words = sentence.toLowerCase(Locale.ROOT).split(" ");

        StringBuilder strTerm = new StringBuilder();
        StringBuilder strQuery = new StringBuilder();

        int length = words.length;
        for (int ind = 2; ind < (length / 2); ind += 3) {
            strTerm.append(words[ind - 2])
                    .append(" ")
                    .append(words[ind - 1])
                    .append(" ")
                    .append(words[ind])
                    .append("\n");
            strQuery.append(words[ind - 2])
                    .append(" <-> ")
                    .append(words[ind - 1])
                    .append(" <-> ")
                    .append(words[ind])
                    .append("\n");
        }

        for (int ind = (length / 2) + 2; ind < length; ind += 2) {
            strTerm.append(words[ind - 2])
                    .append(" ")
                    .append(words[ind - 1])
                    .append("\n");
            strQuery.append(words[ind - 2])
                    .append(" <-> ")
                    .append(words[ind - 1])
                    .append("\n");
        }

        BufferedWriter writerTerm = new BufferedWriter(new FileWriter("terms"));
        writerTerm.write(strTerm.toString());
        writerTerm.close();

        BufferedWriter writerQuery = new BufferedWriter(new FileWriter("queries"));
        writerQuery.write(strQuery.toString());
        writerQuery.close();
    }
}
