/**
 * @description Find all test with extension "ts" or "tsx" use a public method
 * @kind problem
 * @id javascript/find-all-public-methods
 * @problem.severity recommendation
 */
import javascript

predicate isJavaScriptOrTypeScriptFile(File file) {
  file.getExtension() = "ts" or file.getExtension() = "tsx" 
}

predicate isTestMethod(Method m) {
    // This assumes that test methods are prefixed with it()
    m.getName().matches("it") or
    exists(m.getAnAnnotation().getType().getName() = "Test")
}

// Select public methods that are called within test methods
from Method test, Method publicMethod, Call call
where
    isTestMethod(test) and            // Only look at test methods
    publicMethod.hasQualifiedName(_, _) and // Matches methods with a qualified name (any package, any class)
    publicMethod.isPublic() and        // Ensure the method is public
    call.getTarget() = publicMethod and // Ensure the public method is the target of the call
    call.getEnclosingCallable() = test // Ensure the call is from a test method
select test, publicMethod, "Public method called by test"

from File file
where isJavaScriptOrTypeScriptFile(file) and 
      doesNotContainComments(file)
select file, "Found file without comments: " + file.getAbsolutePath()