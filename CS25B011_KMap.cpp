#include <iostream>
#include <vector>
#include <algorithm>
using namespace std;

int n, rows, cols;

vector<vector<int>> kmap;
vector<vector<int>> groups;
// Gray code
int gray(int x) {
    if (x == 0) return 0;
    if (x == 1) return 1;
    if (x == 2) return 3;
    return 2;
}
// Convert K-map position to minterm number
int minterm(int r, int c) {
    // 2 variables -> 2 x 2 K-map
    if (n == 2)
        return (gray(r) * 2) + gray(c);
    // 3 variables -> 2 x 4 K-map
    if (n == 3)
        return (r * 4) + gray(c);
    // 4 variables -> 4 x 4 K-map
    return (gray(r) * 4) + gray(c);
}
// Check whether every cell in a group is 1
bool allOnes(vector<int> cells) {
    for (int x : cells) {
        int r = x / cols;
        int c = x % cols;
        if (kmap[r][c] == 0)
            return false;
    }
    return true;
}
// Create every possible valid K-map group
void makeGroups() {
    // Height can be 1,2,4...
    for (int h = 1; h <= rows; h *= 2) {
        // Width can be 1,2,4...
        for (int w = 1; w <= cols; w *= 2) {
            // Try starting from every row
            for (int r = 0; r < rows; r++) {
                // Try starting from every column
                for (int c = 0; c < cols; c++) {
                    vector<int> g;
                    // Create the rectangle
                    for (int i = 0; i < h; i++) {
                        for (int j = 0; j < w; j++) {
                            // % gives wrap-around
                            int rr = (r + i) % rows;
                            int cc = (c + j) % cols;
                            g.push_back(rr * cols + cc);
                        }
                    }
                    // Remove duplicate cells
                    sort(g.begin(), g.end());
                    g.erase(unique(g.begin(), g.end()), g.end());
                    // Valid group if:
                    // 1. It contains exactly h*w cells
                    // 2. Every cell contains 1
                    if ((int)g.size() == h * w && allOnes(g)) {
                        bool exists = false;
                        for (auto old : groups) {
                            if (old == g) {
                                exists = true;
                                break;
                            }
                        }
                        if (!exists)
                            groups.push_back(g);
                    }
                }
            }
        }
    }
}
// Check whether a group contains a particular cell
bool contains(const vector<int>& a, int x) {
    return find(a.begin(), a.end(), x) != a.end();
}
// Keep only groups that cannot be expanded further
vector<vector<int>> getLargestGroups() {
    vector<vector<int>> result;
    for (auto g : groups) {
        bool insideBigger = false;
        for (auto big : groups) {
            // big must contain more cells
            if (big.size() <= g.size())
                continue;

            bool inside = true;
            for (int x : g) {
                if (!contains(big, x)) {
                    inside = false;
                    break;
                }
            }
            if (inside) {
                insideBigger = true;
                break;
            }
        }
        // If no bigger group contains this group,
        // it is a largest/prime group.
        if (!insideBigger)
            result.push_back(g);
    }
    return result;
}


// Convert a group into a Boolean term
string term(vector<int> g) {
    string s = "";
    // bits[i]:
    // -1 = not checked yet
    //  0 = always 0
    //  1 = always 1
    //  2 = changes, so remove variable
    vector<int> bits(n, -1);
    // Look at every cell in the group
    for (int x : g) {
        int r = x / cols;
        int c = x % cols;
        // Find its minterm number
        int m = minterm(r, c);
        // Extract every variable bit
        for (int b = 0; b < n; b++) {
            int value = (m >> (n - 1 - b)) & 1;
            if (bits[b] == -1)
                bits[b] = value;
            else if (bits[b] != value)
                bits[b] = 2;
        }
    }
    // Convert constant bits into Boolean variables
    for (int i = 0; i < n; i++) {
        // Variable changes inside the group
        // so it disappears from the term.
        if (bits[i] == 2)
            continue;
        // a, b, c, d...
        s += char('a' + i);
        // If bit is 0 -> complemented variable
        if (bits[i] == 0)
            s += "'";
    }
    // Entire map contains 1
    if (s == "")
        return "1";

    return s;
}
// Check whether selected groups cover all 1s
bool coversAll(vector<vector<int>> selected,
               vector<int> ones) {
    for (int x : ones) {
        bool covered = false;
        for (auto g : selected) {
            if (contains(g, x)) {
                covered = true;
                break;
            }
        }
        if (!covered)
            return false;
    }
    return true;
}


// Store all minimum solutions
vector<vector<vector<int>>> solutions;
int bestCount = 1000;
// Try every combination of prime groups
void findSolutions(vector<vector<int>>& prime,
                   int index,
                   vector<vector<int>>& selected,
                   vector<int>& ones) {
    // If all 1s are covered,
    // we have found a solution.
    if (coversAll(selected, ones)) {
        // Better solution
        if ((int)selected.size() < bestCount) {
            bestCount = selected.size();
            solutions.clear();
            solutions.push_back(selected);
        }
        // Another solution with same number of groups
        else if ((int)selected.size() == bestCount) {
            solutions.push_back(selected);
        }
        return;
    }

    // No more groups to try
    if (index == (int)prime.size())
        return;

    // Already worse than best solution
    if ((int)selected.size() >= bestCount)
        return;

    // OPTION 1: Take this group

    selected.push_back(prime[index]);
    findSolutions(prime,
                  index + 1,
                  selected,
                  ones);
    selected.pop_back();

    // OPTION 2: Do not take this group

    findSolutions(prime,
                  index + 1,
                  selected,
                  ones);
}

// MAIN
int main() {

    cout << "Enter number of variables (2, 3 or 4): ";
    cin >> n;


    // Only 2, 3 and 4 variables
    if (n < 2 || n > 4) {

        cout << "Only 2, 3 and 4 variables are supported.\n";

        return 0;
    }

    // Decide K-map size

    if (n == 2) {
        rows = 2;
        cols = 2;
    }

    else if (n == 3) {
        rows = 2;
        cols = 4;
    }

    else {
        rows = 4;
        cols = 4;
    }
    // Create K-map
    kmap.assign(rows, vector<int>(cols));
    cout << "\nEnter K-map values row by row:\n";
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            cin >> kmap[i][j];
        }
    }

    // Find all cells containing 1

    vector<int> ones;
    for (int r = 0; r < rows; r++) {
        for (int c = 0; c < cols; c++) {
            if (kmap[r][c] == 1) {
                // Convert (row,column)
                // into one cell number
                ones.push_back(r * cols + c);
            }
        }
    }
    // No 1s

    if (ones.empty()) {
        cout << "\nF = 0\n";
        return 0;
    }

    // Generate all possible groups

    makeGroups();
    // Keep only largest groups
    vector<vector<int>> prime = getLargestGroups();
    // Find minimum combinations
    vector<vector<int>> selected;
    findSolutions(prime,
                  0,
                  selected,
                  ones);
    // Print answers
    // -----------------------------------------------

    cout << "\nAll possible minimum Boolean expressions:\n";
    vector<string> printed;
    for (auto solution : solutions) {
        vector<string> terms;
        for (auto g : solution)
            terms.push_back(term(g));
        // Sort terms for consistent output
        sort(terms.begin(), terms.end());
        string expression = "";
        for (string t : terms) {
            if (!expression.empty())
                expression += " + ";

            expression += t;
        }

        // Avoid printing duplicate expressions
        if (find(printed.begin(),
                 printed.end(),
                 expression) == printed.end()) {
            printed.push_back(expression);
            cout << expression << "\n";
        }
    }
    return 0;
}