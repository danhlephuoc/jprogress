package se.liu.ida.jprogress.formula;

import se.liu.ida.jprogress.Interpretation;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by dnleng on 30/04/18.
 */
public class Negation extends Formula {
    private Formula formula;

    public Negation(Formula formula) {
        super();
        this.formula = formula;
    }

    public Formula progress(Interpretation interpretation) {
        return new Negation(this.formula.progress(interpretation));
    }

    public TruthValue eval(Interpretation interpretation) {
        if(this.formula.eval(interpretation) == TruthValue.UNKNOWN) {
            return TruthValue.UNKNOWN;
        }
        else if(this.formula.eval(interpretation) == TruthValue.TRUE) {
            return TruthValue.FALSE;
        }
        else {
            return TruthValue.TRUE;
        }
    }

    public Set<String> getAtoms() {
        return formula.getAtoms();
    }

    @Override
    public String toString() {
        return "¬(" + this.formula + ")";
    }
}
