allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}

subprojects {
    pluginManager.withPlugin("com.android.library") {
        val androidExt = project.extensions.findByName("android") as? com.android.build.gradle.LibraryExtension
        if (androidExt != null && androidExt.namespace == null) {
            val generatedNamespace = "com.interswitchng." + project.name.replace("-", "_").replace(".", "_")
            androidExt.namespace = generatedNamespace
            println("Injected namespace $generatedNamespace into ${project.name}")
        }
    }
}
