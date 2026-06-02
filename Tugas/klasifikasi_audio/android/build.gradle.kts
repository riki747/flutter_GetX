allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

// Gunakan projectDirectory.dir("../build") sebagai acuan statis yang aman
val newBuildDir = rootProject.layout.projectDirectory.dir("../build")
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Karena newBuildDir sekarang murni objek Directory, langsung panggil .dir()
    val newSubprojectBuildDir = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}