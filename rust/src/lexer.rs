const OPERATORS : [&'static str; 5] = ["^", "*", "/", "+", "-"];

fn precedence(operator: &str) -> i64 {
    match operator {
        "^" => 4,
        "*" => 3,
        "/" => 3,
        "+" => 2,
        "-" => 2,
        _ => 0,
    }
}

pub fn is_operator(character: &str) -> bool {
    for &operator in OPERATORS.iter() {
        if character == operator {
            return true;
        }
    }
    return false;
}

pub fn lex(code: &str) -> Vec<String> {
    let mut tokens : Vec<String> = vec![];
    let mut index = 0;

    for character in code.graphemes(true) {
        if character == " " {
            index += 1;
        } else if is_operator(character) {
            tokens.push(String::from_str(character));
        } else {
            if tokens.len() > index {
                tokens[index].push_str(character);
            }  else {
                tokens.push(String::from_str(character));
            }
        }
    }

    return tokens
}
